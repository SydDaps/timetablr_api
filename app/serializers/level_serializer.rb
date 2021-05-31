class LevelSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            code: resource.code
        }

    end

end