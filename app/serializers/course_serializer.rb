class CourseSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            code: resource.code,
            level: resource.level.code,
            department: resource.department.code,
            time_tag: resource.time_tag.name,
            lecturers: LecturerSerializer.new( resource.lecturers ).serialize
        }

    end

end