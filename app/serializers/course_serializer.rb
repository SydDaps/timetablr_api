class CourseSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            code: resource.code,
            level: resource.level.code,
            department: resource.department.code,
            time_tag: TimeTagSerializer.new( resource.time_tags ).serialize,
            lecturers: LecturerSerializer.new( resource.lecturers ).serialize
        }

    end

end