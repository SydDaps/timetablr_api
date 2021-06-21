class LecturerSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            email: resource.email,
            schedules: ScheduleSerializer.new( resource.lecture_schedules ).serialize
        }

    end

end