class PairingSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            name: resource.course.name,
            course: resource.course,
            start: resource.meet_time.start.strftime("%H:%M"),
            end: resource.meet_time.end.strftime("%H:%M"),
            lecturers:  LecturerSerializer.new( resource.course.lecturers ).serialize,
            room: resource.room.name,
            day: resource.day.number,
            time_tag: resource.time_tag.name,
            department: resource.course.department,
            level: resource.course.level.code
        }
    end
end
