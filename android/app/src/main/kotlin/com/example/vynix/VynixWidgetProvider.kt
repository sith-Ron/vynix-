package com.example.vynix

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class VynixWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId)
        }
    }

    companion object {
        fun updateWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            val prefs: SharedPreferences = HomeWidgetPlugin.getData(context)

            val pendingTasks = prefs.getInt("pending_tasks", 0)
            val todayEvents = prefs.getInt("today_events", 0)
            val focusMinutes = prefs.getInt("focus_minutes", 0)
            val nextTaskTitle = prefs.getString("next_task_title", null)

            val views = RemoteViews(context.packageName, R.layout.vynix_widget_layout)

            views.setTextViewText(R.id.widget_tasks_count, "$pendingTasks")
            views.setTextViewText(R.id.widget_events_count, "$todayEvents")
            views.setTextViewText(R.id.widget_focus_minutes, "${focusMinutes}m")
            views.setTextViewText(R.id.widget_focus_badge, "${focusMinutes}m focus")
            views.setTextViewText(
                R.id.widget_next_task,
                nextTaskTitle ?: "No pending tasks"
            )

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
