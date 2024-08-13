RSpec.describe Foobara::Generators::TypeGenerator::GenerateType do
  let(:name) { "SomeOrg::SomeDomain::SomeType" }
  let(:type) { Foobara::Generators::TypeGenerator::TypeConfig::TypeType::TYPE }

  let(:inputs) do
    {
      name:,
      type:,
      description: "whatever"
    }
  end
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }

  it "generates a type" do
    expect(outcome).to be_success

    type_file = result["src/some_org/some_domain/types/some_type.rb"]
    expect(type_file).to include("module SomeOrg")
    expect(type_file).to include("module SomeDomain")
    expect(type_file).to include("foobara_register_type :some_type")
  end

  context "with all options" do
    let(:inputs) do
      {
        name: "SomeNamespace::SomeType",
        description: "whatever",
        domain: "SomeOrg::SomeDomain"
      }
    end

    it "generates a type using the given options" do
      expect(outcome).to be_success

      type_file = result["src/some_org/some_domain/types/some_namespace/some_type.rb"]
      expect(type_file).to include("module SomeOrg")
      expect(type_file).to include("module SomeDomain")
      expect(type_file).to include("module SomeNamespace")
      expect(type_file).to include("foobara_register_type :some_type")
    end
  end
end
