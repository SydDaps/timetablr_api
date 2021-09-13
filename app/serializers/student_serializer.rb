class StudentSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            email: resource.email,
            level: resource.level.id,
            department: resource.department.id
        }
    end
end