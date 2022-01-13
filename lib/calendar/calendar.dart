import 'event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final formKey = GlobalKey<FormState>(); //key for form

  String adresse = "";
  String time = "";

  TextEditingController _eventController = TextEditingController();
  TextEditingController _eventController2 = TextEditingController();
  TextEditingController _eventController3 = TextEditingController();
  TextEditingController _eventController4 = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Calendar"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(2021),
              lastDay: DateTime(2060),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,

              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusedDay);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              eventLoader: _getEventsfromDay,

              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ..._getEventsfromDay(selectedDay).map(
              (Event event) => Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey[300]),
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(right: 10, left: 30),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    "https://st.depositphotos.com/2196544/2311/v/600/depositphotos_23119986-stock-illustration-woman-presenting.jpg"),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //Cleaner Name
                                    event.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    //Cleaner Phone Number
                                    event.number,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    //Location of service
                                    event.location,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    //Time of service
                                    event.time,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                      "Add a Cleaning Appointment",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: Container(
                      height: 300,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                          key: formKey, //key for form

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 3),
                              TextFormField(
                                controller: _eventController,
                                decoration: InputDecoration(
                                  labelText: "Enter the cleaner name",
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueGrey[900]),
                                ),
                              ),
                              SizedBox(height: 4),
                              TextFormField(
                                controller: _eventController2,
                                decoration: InputDecoration(
                                  labelText: "Enter the cleaner phone number",
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueGrey[900]),
                                ),
                              ),
                              SizedBox(height: 4),
                              TextFormField(
                                controller: _eventController3,
                                decoration: InputDecoration(
                                  labelText: "Enter the service location",
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueGrey[900]),
                                ),
                              ),
                              SizedBox(height: 4),
                              TextFormField(
                                controller: _eventController4,
                                decoration: InputDecoration(
                                  labelText: "Enter the service time",
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueGrey[900]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text("Save"),
                        onPressed: () {
                          if (_eventController.text.isEmpty) {
                          } else {
                            if (selectedEvents[selectedDay] != null) {
                              selectedEvents[selectedDay].add(
                                Event(
                                    title: _eventController.text,
                                    number: _eventController2.text,
                                    location: _eventController3.text,
                                    time: _eventController4.text),
                              );
                            } else {
                              selectedEvents[selectedDay] = [
                                Event(
                                    title: _eventController.text,
                                    number: _eventController2.text,
                                    location: _eventController3.text,
                                    time: _eventController4.text)
                              ];
                            }
                          }
                          Navigator.pop(context);
                          _eventController.clear();
                          _eventController2.clear();
                          _eventController3.clear();
                          _eventController4.clear();
                          setState(() {});
                          return;
                        },
                      ),
                    ],
                  ));
        },
        label: Text("Add Appointment"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
