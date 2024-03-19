require "English"

module Foobara
  module Generators
    module TypeGenerator
      class TypeConfig < Foobara::Model
        class TypeType
          TYPE = :type
          MODEL = :model
          ENTITY = :entity
        end

        attributes do
          name :string
          type :string, default: TypeType::TYPE, one_of: TypeType
          description :string, :allow_nil
          domain :string, :allow_nil
          organization :string, :allow_nil
        end

        def module_path
          @module_path ||= [*organization&.split("::"), *domain&.split("::"), *name.split("::")]
        end
      end
    end
  end
end
