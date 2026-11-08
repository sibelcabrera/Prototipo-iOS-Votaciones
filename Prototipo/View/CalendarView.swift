import SwiftUI

struct CalendarView: View {
    
    @StateObject private var apiService = Consumo_Api()
    @State private var todosLosEventos: [Evento] = []
    @State private var selectedDate: Date = Date()
    @State private var mensajeEstado: String = "Cargando eventos..."
    @State private var estaCargando: Bool = true
    
    // Lógica de Conversión y Filtrado
    private func fullDate(from evento: Evento, in date: Date) -> Date? {
        let calendar = Calendar.current
        var targetYear = calendar.component(.year, from: date)
        let selectedMonth = calendar.component(.month, from: date)
        
        
        let esLocale = Locale(identifier: "es_ES")
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        monthFormatter.locale = esLocale
        
        guard let eventMonthDate = monthFormatter.date(from: evento.mes) else {
            print("Error: No se pudo parsear el mes '\(evento.mes)'")
            return nil
        }
        let eventMonth = calendar.component(.month, from: eventMonthDate)
        
        if eventMonth == 1 && selectedMonth >= 11 {
            targetYear += 1
        }
        
        let eventDateString = "\(evento.dia) \(evento.mes) \(targetYear)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = esLocale
        dateFormatter.calendar = calendar
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.date(from: eventDateString)
    }

    // Propiedad: Eventos que ocurren en el día seleccionado
    var eventosDeHoy: [Evento] {
        let calendar = Calendar.current
        
        return todosLosEventos.filter { evento in
            guard let eventDate = fullDate(from: evento, in: selectedDate) else { return false }
            return calendar.isDate(eventDate, inSameDayAs: selectedDate)
        }
    }
    
    // Propiedad: Eventos que ocurren después del día seleccionado
    var eventosFuturos: [Evento] {
        let calendar = Calendar.current
        
        let startOfSelectedDate = calendar.startOfDay(for: selectedDate)
        
        return todosLosEventos.filter { evento in
            guard let eventDate = fullDate(from: evento, in: selectedDate) else { return false }
            
            let startOfEventDate = calendar.startOfDay(for: eventDate)
            
            return startOfEventDate > startOfSelectedDate
        }
    }
    
    // Propiedad: Verdadero si hay eventos para mostrar
    var tieneEventosProgramados: Bool {
        return !eventosDeHoy.isEmpty || !eventosFuturos.isEmpty
    }
    
    // Cuerpo principal de la vista
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding(.horizontal)
                .accentColor(.blue)
                .environment(\.locale, Locale(identifier: "es_ES"))
                
                Divider()
                
                if estaCargando {
                    ProgressView(mensajeEstado)
                        .padding(.top, 50)
                } else if !tieneEventosProgramados {
                    Text("No hay eventos programados para esta fecha.")
                        .foregroundColor(.gray)
                        .padding(.top, 50)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            // SECCIÓN 1: EVENTOS DE HOY
                            if !eventosDeHoy.isEmpty {
                                Text("Eventos de hoy:")
                                    .font(.title2.bold())
                                    .padding([.top, .horizontal])
                                
                                ForEach(eventosDeHoy) { evento in
                                    EventRow(
                                        day: evento.dia,
                                        month: evento.mes,
                                        title: evento.nombre,
                                        dateRange: evento.rangoFechas,
                                        location: evento.ubicacion
                                    )
                                }
                                .padding(.horizontal)
                            }
                            
                            // SECCIÓN 2: FUTUROS EVENTOS
                            if !eventosFuturos.isEmpty {
                                Text("Futuros eventos:")
                                    .font(.title2.bold())
                                    .padding([.top, .horizontal])
                                
                                ForEach(eventosFuturos) { evento in
                                    EventRow(
                                        day: evento.dia,
                                        month: evento.mes,
                                        title: evento.nombre,
                                        dateRange: evento.rangoFechas,
                                        location: evento.ubicacion
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Calendario-Eventos")
            .navigationBarTitleDisplayMode(.inline)
            
            .task {
                await cargarEventos()
            }
            .onChange(of: selectedDate) { oldValue, newValue in
                updateCalendar()
            }

            // Overlay para el botón de agregar
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                    }
                }
            )
        }
    }
    
    // Función para obtener eventos de la API
    func cargarEventos() async {
        estaCargando = true
        mensajeEstado = "Cargando eventos..."
        do {
            self.todosLosEventos = try await apiService.fetchEventos()
            self.estaCargando = false
        } catch {
            print("Error al cargar eventos: \(error)")
            self.mensajeEstado = "Error al cargar: \(error.localizedDescription)"
            self.estaCargando = false
        }
    }
}

// Función auxiliar
func updateCalendar() {
       print("Actualizar calendario")
}


// Estructura: Fila de Evento (EventRow)
struct EventRow: View {
    var day: String
    var month: String
    var title: String
    var dateRange: String
    var location: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text(day)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.blue)
                Text(month)
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.blue)
                Text(dateRange)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(location)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    CalendarView()
}
