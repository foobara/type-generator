require "pathname"

require_relative "type_config"

module Foobara
  module Generators
    module TypeGenerator
      class GenerateType < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs TypeConfig

        def execute
          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        attr_accessor :manifest_data

        def base_generator
          Generators::TypeGenerator
        end

        # TODO: delegate this to base_generator
        def templates_dir
          # TODO: implement this?
          # :nocov:
          "#{__dir__}/../templates"
          # :nocov:
        end

        def add_initial_elements_to_generate
          elements_to_generate << type_config
        end

        def type_config
          @type_config ||= TypeConfig.new(inputs)
        end
      end
    end
  end
end
