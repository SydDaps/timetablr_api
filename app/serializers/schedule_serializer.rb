class ScheduleSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            day: resource.day,
            start_at: resource.schedule_time.start,
            end_at: resource.schedule_time.end
        }
    end
end