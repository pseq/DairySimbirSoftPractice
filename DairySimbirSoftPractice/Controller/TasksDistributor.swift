//
//  TasksDistributor.swift
//  DairySimbirSoftPractice
//
//  Created by mac on 18.12.2024.
//

import Foundation

protocol TasksDistributionProtocol {
    func tasksByHoursDistribution(_ date: Date) -> [Int: [TaskItem]]
}

// Здесь распределяем список задач для каждого часа указанных суток
struct TasksDistributor: TasksDistributionProtocol {
    let dataService = DataService()
    let calendar = Calendar.current

    func tasksByHoursDistribution(_ date: Date) -> [Int: [TaskItem]] {
        var tasksByHours = [Int: [TaskItem]]()
        let currentDayStart = date.getDatePlusDays(0)
        let nextDayStart = date.getDatePlusDays(1)
        let dailyTasks = dataService.loadTasks().filter {
            $0.date_start < (nextDayStart) &&       // Берём задачи, которые начинаются до конца текущего дня
            $0.date_finish >= (currentDayStart)     // и заканчиваются до его окончания,
        }
        for dailyTask in dailyTasks {               // и каждую такую задачу
            let taskStartedYesterday = dailyTask.date_start < currentDayStart
            let taskStartHour = taskStartedYesterday ? 0 : calendar.component(.hour, from: dailyTask.date_start)
            let taskFinishTomorrow = dailyTask.date_finish > nextDayStart
            let taskEndHour = taskFinishTomorrow ? 23 : calendar.component(.hour, from: dailyTask.date_finish - TimeInterval(1))
            for hour in taskStartHour...taskEndHour { // добавляем в каждый час, когда она актуальна
                
                if tasksByHours[hour] == nil {
                    tasksByHours[hour] = [dailyTask]
                } else {
                    tasksByHours[hour]!.append(dailyTask)
                }
            }
        }
        return tasksByHours
    }
}
