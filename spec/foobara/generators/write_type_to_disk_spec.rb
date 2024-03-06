RSpec.describe Foobara::Generators::TypeGenerator::WriteTypeToDisk do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:inputs) do
    {
      type_config:,
      output_directory:
    }
  end
  let(:type_config) do
    {
      name:,
      type: Foobara::Generators::TypeGenerator::TypeConfig::TypeType::TYPE,
      description: "whatever"
    }
  end
  let(:name) { "SomeOrg::SomeDomain::SomeType" }
  let(:output_directory) { "#{__dir__}/../../../tmp/type_test_suite_output" }

  before do
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(described_class).to receive(:git_commit).and_return(nil)
    allow_any_instance_of(described_class).to receive(:rubocop_autocorrect).and_return(nil)
    # rubocop:enable RSpec/AnyInstance
    FileUtils.rm_rf output_directory
  end

  describe "#run" do
    it "contains base files" do
      expect(outcome).to be_success

      expect(command.paths_to_source_code.keys).to include("src/some_org/some_domain/types/some_type.rb")
    end
  end

  describe "#output_directory" do
    context "with no output directory" do
      let(:inputs) do
        {
          type_config:
        }
      end

      it "writes files to the current directory" do
        command.cast_and_validate_inputs
        expect(command.output_directory).to eq(".")
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
