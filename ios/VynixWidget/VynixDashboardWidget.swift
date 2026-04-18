import SwiftUI
import WidgetKit

// MARK: - Timeline Entry

struct VynixEntry: TimelineEntry {
    let date: Date
    let pendingTasks: Int
    let todayEvents: Int
    let focusMinutes: Int
    let nextTaskTitle: String?
}

// MARK: - Timeline Provider

struct VynixTimelineProvider: TimelineProvider {
    private let appGroupId = "group.com.example.vynix"

    func placeholder(in context: Context) -> VynixEntry {
        VynixEntry(
            date: Date(),
            pendingTasks: 3,
            todayEvents: 2,
            focusMinutes: 25,
            nextTaskTitle: "Review notes"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (VynixEntry) -> Void) {
        completion(readEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<VynixEntry>) -> Void) {
        let entry = readEntry()
        // Refresh every 15 minutes
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func readEntry() -> VynixEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        let pendingTasks = defaults?.integer(forKey: "pending_tasks") ?? 0
        let todayEvents = defaults?.integer(forKey: "today_events") ?? 0
        let focusMinutes = defaults?.integer(forKey: "focus_minutes") ?? 0
        let nextTaskTitle = defaults?.string(forKey: "next_task_title")

        return VynixEntry(
            date: Date(),
            pendingTasks: pendingTasks,
            todayEvents: todayEvents,
            focusMinutes: focusMinutes,
            nextTaskTitle: nextTaskTitle
        )
    }
}

// MARK: - Widget Views

struct VynixDashboardWidgetEntryView: View {
    var entry: VynixEntry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            smallView
        case .systemMedium:
            mediumView
        case .accessoryCircular:
            lockScreenCircularView
        case .accessoryRectangular:
            lockScreenRectangularView
        default:
            mediumView
        }
    }

    // MARK: Small (Home Screen)

    private var smallView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "bolt.fill")
                    .foregroundColor(.indigo)
                Text("Vynix")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            Spacer()
            HStack(spacing: 12) {
                statBadge(icon: "checkmark.circle", value: "\(entry.pendingTasks)", color: .orange)
                statBadge(icon: "calendar", value: "\(entry.todayEvents)", color: .indigo)
            }
            if let task = entry.nextTaskTitle {
                Text(task)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }

    // MARK: Medium (Home Screen)

    private var mediumView: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.indigo)
                    Text("Vynix")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Spacer()
                if let task = entry.nextTaskTitle {
                    Text("Next:")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(task)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .lineLimit(2)
                }
            }
            Spacer()
            VStack(spacing: 10) {
                statRow(icon: "checkmark.circle.fill", label: "Tasks", value: "\(entry.pendingTasks)", color: .orange)
                statRow(icon: "calendar", label: "Events", value: "\(entry.todayEvents)", color: .indigo)
                statRow(icon: "timer", label: "Focus", value: "\(entry.focusMinutes)m", color: .green)
            }
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }

    // MARK: Lock Screen — Circular

    private var lockScreenCircularView: some View {
        VStack(spacing: 2) {
            Image(systemName: "checkmark.circle")
                .font(.title3)
            Text("\(entry.pendingTasks)")
                .font(.headline)
                .fontWeight(.bold)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }

    // MARK: Lock Screen — Rectangular

    private var lockScreenRectangularView: some View {
        HStack(spacing: 8) {
            Image(systemName: "bolt.fill")
                .font(.title3)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(entry.pendingTasks) tasks · \(entry.todayEvents) events")
                    .font(.headline)
                if let task = entry.nextTaskTitle {
                    Text(task)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }

    // MARK: Helpers

    private func statBadge(icon: String, value: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(color)
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }

    private func statRow(icon: String, label: String, value: String, color: Color) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(color)
                .frame(width: 16)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

// MARK: - Widget Configuration

struct VynixDashboardWidget: Widget {
    let kind: String = "VynixDashboardWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: VynixTimelineProvider()) { entry in
            VynixDashboardWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Vynix Dashboard")
        .description("Quick glance at tasks, events, and focus.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryCircular,
            .accessoryRectangular,
        ])
    }
}

#Preview(as: .systemSmall) {
    VynixDashboardWidget()
} timeline: {
    VynixEntry(date: Date(), pendingTasks: 5, todayEvents: 3, focusMinutes: 25, nextTaskTitle: "Review project proposal")
}

#Preview(as: .systemMedium) {
    VynixDashboardWidget()
} timeline: {
    VynixEntry(date: Date(), pendingTasks: 5, todayEvents: 3, focusMinutes: 25, nextTaskTitle: "Review project proposal")
}
