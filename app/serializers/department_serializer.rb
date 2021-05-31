class DepartmentSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            code: resource.code    
        }
    end
end