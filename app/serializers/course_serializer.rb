class CourseSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            code: resource.code,
            department: resource.department.code,
            type: resource.kind,
            time_tags: TimeTagSerializer.new( resource.time_tags ).serialize.map{
                |tag| tag[:id]
            },
            lecturers: LecturerSerializer.new( resource.lecturers ).serialize.map{
                |lecturer|  lecturer[:id]
            },
            schedules: ScheduleSerializer.new( resource.course_schedules ).serialize
        }

    end

end