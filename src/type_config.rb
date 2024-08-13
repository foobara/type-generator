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
          @module_path ||= domain_path + post_domain_path
        end

        def domain_path
          @domain_path ||= [*organization&.split("::"), *domain&.split("::")]
        end

        def post_domain_path
          name.split("::")
        end

        def has_domain?
          !domain_path.empty?
        end
      end
    end
  end
end
