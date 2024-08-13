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
            domain_path, post_domain_path = if has_domain?
                                              [self.domain_path, self.post_domain_path]
                                            else
                                              *path, file = module_path.map { |part| Util.underscore(part) }
                                              [path, [file]]
                                            end

            domain_path = domain_path.map { |part| Util.underscore(part) }
            post_domain_path = post_domain_path.map { |part| Util.underscore(part) }

            *post_domain_path, file = post_domain_path

            path = ["src", *domain_path]

            unless path.last == "types"
              path << "types"
            end

            [*path, *post_domain_path, "#{file}.rb"]
          end

          alias type_config relevant_manifest

          def templates_dir
            "#{__dir__}/../templates"
          end
        end
      end
    end
  end
end
