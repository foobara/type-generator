module Foobara
  module Generators
    module TypeGenerator
      module Generators
        class TypeGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when TypeConfig
                [
                  Generators::TypeGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          def template_path
            ["src", "#{type}.rb.erb"]
          end

          def target_path
            *path, file = module_path.map { |part| Util.underscore(part) }

            file = "#{file}.rb"

            ["src", *path, "types", file]
          end

          alias type_config relevant_manifest

          def templates_dir
            "#{__dir__}/../templates"
          end

          # TODO: promote this up to base project
          def ==(other)
            # :nocov:
            self.class == other.class && type_config == other.type_config
            # :nocov:
          end

          def hash
            type_config.hash
          end
        end
      end
    end
  end
end