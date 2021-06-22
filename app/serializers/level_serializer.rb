class LevelSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            level_id: resource.id,
            code: resource.code
        }

    end

end