//
//  AppearanceSettings.swift
//  Beyond
//
//  Created by Jeremy Villeneuve on 12/1/24.
//

import SwiftUI

class AppearanceSettings: ObservableObject {
    @Published var schemes: [ColorScheme] = [

        ColorScheme(
            name: "Azure",
            background: .blue, //Changes the color at the top and the toolbar
            primary: .white, //Primary Color of the UI
            secondary: .white, //Color of Calendar
            calendarBorder: .blue,//Color of calendar border
            calendarToday: .blue,//Color of Highlight on today's date
            calendarChoose: .cyan,//Color of Highlight on chosen date
            button: .white, //Color of button
            buttonText: .blue, //Color of button text
            shadow: .blue, //Shadow of Start Button
            progressBar: .blue, //Progress bar for widgets/
            accent: .white, //Color of tabs in the tabView
            addWorkoutText: .white,//Text of Workouts created by user
            addWorkoutCategory: .black, //Text of the category like "Biceps" or "Abs"
            addWorkoutRow: .blue, //Color that exercises are displayed on
            addWorkoutSelect: .cyan,
            editWorkoutButton: .white, //Color of pencil to edit workout
            deleteWorkoutButton: .red, //Color of trash to delete workout
            editWorkoutBackground: .blue,//Color of background for EditWorkoutView
            editWorkoutRow: .black, //Color of row that exercises are displayed
            editWorkoutText: .blue, //Color of exercise text on editWorkoutRow
            widgetText: .black,
            text: .black //Text of "Progress Buddy" and Menu, text when no workouts exist
        ),
        ColorScheme(
            name: "Bold Rose",
            background: Color(red: 1.0, green: 0.5, blue: 0.86), //Changes the color at the top and the toolbar
            primary: .white, //Primary Color of the UI
            secondary: .white, //Color of Calendar
            calendarBorder: .black,
            calendarToday: Color(red: 1.0, green: 0.2, blue: 0.86),
            calendarChoose: Color(red: 1.0, green: 0.5, blue: 0.86),
            button: .white, //Color of button
            buttonText: .pink, //Color of button text
            shadow: .pink, //Shadow of Start Button
            progressBar: Color(red: 1.0, green: 0.5, blue: 0.86),//Progress bar for widgets
            accent: .white, //Color of tabs in the tabView
            addWorkoutText: .white,//Text of Workouts created by user
            addWorkoutCategory: .black, //Text of the category like "Biceps" or "Abs"
            addWorkoutRow: Color(red: 1.0, green: 0.5, blue: 0.86),
            addWorkoutSelect: Color(red: 1.0, green: 0.2, blue: 0.86),
            editWorkoutButton: .black,
            deleteWorkoutButton: .red,
            editWorkoutBackground: Color(red: 1.0, green: 0.5, blue: 0.86),
            editWorkoutRow: .black,
            editWorkoutText: Color(red: 1.0, green: 0.5, blue: 0.86),
            widgetText: .black,
            text: .black //Text of "Progress Buddy" and Menu, text when no workouts exist
        )
    ]
    @Published var currentScheme: ColorScheme
    init() {
        // Default color scheme
        currentScheme = ColorScheme(
            name: "Azure",
            background: .blue, //Changes the color at the top and the toolbar
            primary: .white, //Primary Color of the UI
            secondary: .white, //Color of Calendar
            calendarBorder: .blue,//Color of calendar border
            calendarToday: .blue,//Color of Highlight on today's date
            calendarChoose: .cyan,//Color of Highlight on chosen date
            button: .white, //Color of button
            buttonText: .blue, //Color of button text
            shadow: .blue, //Shadow of Start Button
            progressBar: .blue, //Progress bar for widgets/
            accent: .white, //Color of tabs in the tabView
            addWorkoutText: .white,//Text of Workouts created by user
            addWorkoutCategory: .black, //Text of the category like "Biceps" or "Abs"
            addWorkoutRow: .blue, //Color that exercises are displayed on
            addWorkoutSelect: .cyan,
            editWorkoutButton: .white, //Color of pencil to edit workout
            deleteWorkoutButton: .red, //Color of trash to delete workout
            editWorkoutBackground: .black,//Color of background for EditWorkoutView
            editWorkoutRow: .white, //Color of row that exercises are displayed
            editWorkoutText: .blue, //Color of exercise text on editWorkoutRow
            widgetText: .black,
            text: .black //Text of "Progress Buddy" and Menu, text when no workouts exist
        )
    }
       
       func changeScheme(to scheme: ColorScheme) {
           currentScheme = scheme
       }
   }
//        ColorScheme(
//            name: "Default",
//            background: .black, //Changes the color at the top and the toolbar
//            primary: .white, //Primary Color of the UI
//            secondary: .white, //Color of Calendar
//            calendarBorder: .black,
//            calendarToday: .blue,
//            calendarChoose: .cyan,
//            button: .cyan, //Color of button
//            buttonText: .white, //Color of button text
//            shadow: .cyan, //Shadow of Start Button
//            progressBar: .blue, //Progress bar for widgets/
//            accent: .white, //Color of tabs in the tabView
//            addWorkoutText:.black,//Text of Workouts created by user
//            addWorkoutCategory: .blue, //Text of the category like "Biceps" or "Abs"
//            addWorkoutRow: .cyan,
//            addWorkoutSelect: .blue,
//            editWorkoutButton: .blue,
//            deleteWorkoutButton: .red,
//            editWorkoutBackground: .black,
//            editWorkoutRow: .cyan,
//            editWorkoutText: .white,
//            widgetText: .black,
//            text: .black //Text of "Progress Buddy" and Menu, text when no workouts exist
//        ),
//
//        ColorScheme(
//            name: "Modern",
//            background: .black, //Changes the color at the top and the toolbar
//            primary: .black, //Primary Color of the UI
//            secondary: .black, //Color of Calendar Background
//            calendarBorder: .white,
//            calendarToday: .blue,
//            calendarChoose: .cyan,
//            button: .white, //Color of button
//            buttonText: .black, //Color of button text
//            shadow: .white, //Shadow of Start Button
//            progressBar: .white, //Progress bar for widgets/
//            accent: .white, //Color of tabs in the tabView
//            addWorkoutText: .black,//Text of Workouts created by user
//            addWorkoutCategory: .blue, //Text of the category like "Biceps" or "Abs"
//            addWorkoutRow: .white,
//            addWorkoutSelect: .gray,
//            editWorkoutButton: .blue,
//            deleteWorkoutButton: .red,
//            editWorkoutBackground: .black,
//            editWorkoutRow: .cyan,
//            editWorkoutText: .white,
//            widgetText: .white,
//            text: .white //Text of "Progress Buddy" and Menu, text when no workouts exist
//
//
//        ),
//        ColorScheme(
//            name: "Crimson",
//            background: .black, //Changes the color at the top and the toolbar and EditWorkoutUI
//            primary: Color(red: 0.8, green: 0.0, blue: 0.0), //Primary Color of the UI
//            secondary: .white, //Color of Calendar
//            calendarBorder: .black,
//            calendarToday: Color(red: 0.8, green: 0.0, blue: 0.0),
//            calendarChoose: .red,
//            button: .white, //Color of button
//            buttonText: Color(red: 0.8, green: 0.0, blue: 0.0), //Color of button text
//            shadow: .white, //Shadow of Start Button
//            progressBar: .black, //Progress bar for widgets/
//            accent: .red, //Color of tabs in the tabView
//            addWorkoutText:Color(red: 0.8, green: 0.0, blue: 0.0),//Text of Workouts created by user
//            addWorkoutCategory:.black, //Text of the category like "Biceps" or "Abs"
//            addWorkoutRow: .black,
//            addWorkoutSelect: Color(red: 0.8, green: 0.0, blue: 0.0),
//            editWorkoutButton: .white,
//            deleteWorkoutButton: .red,
//            editWorkoutBackground: .black,
//            editWorkoutRow: .white,
//            editWorkoutText: .white,
//            widgetText: .white,
//            text: .black //Text of "Progress Buddy" and Menu, text when no workouts exist
