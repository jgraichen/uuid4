require 'spec_helper'

describe UUID4 do
  let(:uuid_str) { 'd963f5a0-ae29-4669-b00b-050023464080' }
  let(:uuid_urn) { 'urn:uuid:d963f5a0-ae29-4669-b00b-050023464080' }
  let(:uuid_cmp) { 'd963f5a0ae294669b00b050023464080' }
  let(:uuid_int) { 288961494395080879479663941903536504960 }
  let(:uuid_b62) { '6Cd11GvqKza4R2wbYNurfi' }
  let(:uuid)     { UUID4.new(uuid_int) }

  it 'has a version number' do
    expect(UUID4::VERSION).not_to be nil
  end

  describe '#initialize' do
    subject { UUID4.new(value) }

    context 'nothing' do
      subject { UUID4.new }
      it { expect(subject).to be_truthy }
    end

    context 'with string' do
      let(:value) { uuid_str }
      it { expect(subject.to_str).to eq uuid_str }
    end

    context 'with compact string' do
      let(:value) { uuid_cmp }
      it { expect(subject.to_str).to eq uuid_str }
    end

    context 'with integer' do
      let(:value) { uuid_int }
      it { expect(subject.to_str).to eq uuid_str }
    end

    context 'with base62 string' do
      let(:value) { uuid_b62 }
      it { expect(subject.to_str).to eq uuid_str }

      context 'with shorter base62 string' do
        let(:value) { '1vGiOCdOqnKYhO' }
        it { is_expected.to eq '00000000-0000-4000-b000-000000000000' }
      end
    end

    context 'with urn string' do
      let(:value) { uuid_urn }
      it { expect(subject.to_str).to eq uuid_str }
    end

    context 'with invalid string' do
      let(:value) { 'this-is-not-a-uuid' }

      it 'raises an error' do
        expect { subject }.to raise_error(TypeError) do |err|
          expect(err.message).to include(value)
        end
      end
    end
  end

  describe '.try_convert' do
    subject { UUID4.try_convert(value) }

    context 'with nil' do
      let(:value) { nil }
      it { expect(subject).to be_nil }
    end

    context 'with UUID' do
      let(:value) { uuid }
      it { expect(subject).to equal uuid }
    end

    context 'with object responding to #to_uuid4' do
      context 'returning a UUID object' do
        let(:value) do
          Object.new.tap do |o|
            def o.to_uuid4
              UUID4('6Cd11GvqKza4R2wbYNurfi')
            end
          end
        end

        it { is_expected.to be_a ::UUID4 }
        it { expect(subject.to_str).to eq uuid_str }
      end
    end

    context 'with string' do
      let(:value) { uuid_str }
      it { is_expected.to be_a ::UUID4 }
      it { expect(subject.to_str).to eq uuid_str }
    end

    context 'with compact string' do
      let(:value) { uuid_cmp }
      it { is_expected.to be_a ::UUID4 }
      it { expect(subject.to_str).to eq uuid_str }
    end

    context 'with integer' do
      let(:value) { uuid_int }
      it { is_expected.to be_a ::UUID4 }
      it { expect(subject.to_str).to eq uuid_str }
    end

    context 'with base62 string' do
      let(:value) { uuid_b62 }
      it { is_expected.to be_a ::UUID4 }
      it { expect(subject.to_str).to eq uuid_str }

      context 'with shorter base62 string' do
        let(:value) { '1vGiOCdOqnKYhO' }
        it { is_expected.to be_a ::UUID4 }
        it { is_expected.to eq '00000000-0000-4000-b000-000000000000' }
      end
    end

    context 'with urn string' do
      let(:value) { uuid_urn }
      it { is_expected.to be_a ::UUID4 }
      it { expect(subject.to_str).to eq uuid_str }
    end

    context 'with invalid integer' do
      let(:value) { 565 }
      it { expect(subject).to be_nil }
    end

    context 'with invalid string (I)' do
      let(:value) { 'fh47df7ffj398' }
      it { expect(subject).to be_nil }
    end

    context 'with invalid string (II)' do
      let(:value) { 'abcdefg_ijkl6574mno' }
      it { expect(subject).to be_nil }
    end

    context 'with invalid base62 string (valid + newline)' do
      let(:value) { "mainframes2018\nmumbojumbo" }
      it { is_expected.to be_nil }
    end
  end

  describe '#valid?' do
    subject { UUID4.valid?(value) }

    context 'with string' do
      let(:value) { uuid_str }
      it { is_expected.to be_truthy }
    end

    context 'with compact string' do
      let(:value) { uuid_cmp }
      it { is_expected.to be_truthy }
    end

    context 'with integer' do
      let(:value) { uuid_int }
      it { is_expected.to be_truthy }
    end

    context 'with base62 string' do
      let(:value) { uuid_b62 }
      it { is_expected.to be_truthy }

      context 'with shorter base62 string' do
        let(:value) { '1vGiOCdOqnKYhO' }
        it { is_expected.to be_truthy }
      end
    end

    context 'with urn string' do
      let(:value) { uuid_urn }
      it { is_expected.to be_truthy }
    end

    context 'with random string' do
      let(:value) { 'abcde' }
      it { is_expected.to be_falsy }
    end
  end

  describe '#to_s' do
    subject { uuid.to_s }
    it { is_expected.to be_a String }
    it { is_expected.to eq uuid_str }

    context 'with format:' do
      subject { uuid.to_s(format: format) }

      context ':default' do
        let(:format) { :default }
        it { is_expected.to be_a String }
        it { is_expected.to eq uuid_str }
      end

      context ':compact' do
        let(:format) { :compact }
        it { is_expected.to be_a String }
        it { is_expected.to eq uuid_cmp }
      end

      context ':base62' do
        let(:format) { :base62 }
        it { is_expected.to be_a String }
        it { is_expected.to eq uuid_b62 }
      end

      context ':urn' do
        let(:format) { :urn }
        it { is_expected.to be_a String }
        it { is_expected.to eq uuid_urn }
      end
    end
  end

  describe '#to_str' do
    subject { uuid.to_s }
    it { is_expected.to be_a String }
    it { is_expected.to eq uuid_str }
  end

  describe '#to_int' do
    subject { uuid.to_int }
    it { is_expected.to be_a Numeric }
    it { is_expected.to eq uuid_int }
  end

  describe '#to_uuid' do
    subject { uuid.to_uuid }
    it { is_expected.to eq uuid_str }
  end

  describe '#to_uuid4' do
    subject { uuid.to_uuid4 }
    it { is_expected.to eq uuid }
  end

  describe '#==' do
    subject { uuid == value }

    context 'with UUID4' do
      let(:value) { UUID4.new(uuid_str) }
      it { is_expected.to be_truthy }
    end

    context 'with matching UUID string' do
      let(:value) { uuid_str }
      it { is_expected.to be_truthy }
    end

    context 'with matching compact UUID string' do
      let(:value) { uuid_cmp }
      it { is_expected.to be_truthy }
    end

    context 'with matching base62 string' do
      let(:value) { uuid_b62 }
      it { is_expected.to be_truthy }
    end

    context 'with matching URN string' do
      let(:value) { uuid_urn }
      it { is_expected.to be_truthy }
    end

    context 'with matching UUID integer' do
      let(:value) { uuid_int }
      it { is_expected.to be_truthy }
    end

    context 'with non-matching string' do
      let(:value) { '37475665tggg' }
      it { is_expected.to be_falsy }
    end

    context 'with non-matching integer' do
      let(:value) { 4983475687243253428944 }
      it { is_expected.to be_falsy }
    end
  end

  describe '#as_json' do
    subject { uuid.as_json }

    it { is_expected.to eq uuid.to_s }

    describe 'JSON.dump' do
      subject { JSON.dump(uuid) }
      it { is_expected.to eq uuid.to_s.inspect }
    end

    describe '::ActiveSupport::JSON.encode' do
      subject { ::ActiveSupport::JSON.encode(uuid) }
      it { is_expected.to eq uuid.to_s.inspect }
    end

    context 'with additional arguments' do
      describe '#as_json' do
        subject { uuid.as_json(a: 1, b: 2) }
        it { is_expected.to eq uuid.to_s }
      end

      describe '::ActiveSupport::JSON.encode' do
        subject { ::ActiveSupport::JSON.encode(uuid, mode: :bla) }
        it { is_expected.to eq uuid.to_s.inspect }
      end
    end
  end

  describe 'Numeric#==' do
    subject { value == uuid }

    context 'with matching integer' do
      let(:value) { uuid_int }
      it { is_expected.to be_truthy }
    end

    context 'with non-matching integer' do
      let(:value) { 4983475687243253428944 }
      it { is_expected.to be_falsy }
    end
  end

  describe 'String#==' do
    subject { value == uuid }

    context 'with matching string' do
      let(:value) { uuid_str }
      it { is_expected.to be_truthy }
    end

    context 'with matching compact string' do
      let(:value) { uuid_cmp }
      it { is_expected.to be_truthy }
    end

    context 'with matching base62 string' do
      let(:value) { uuid_b62 }
      it { is_expected.to be_truthy }
    end

    context 'with matching URN string' do
      let(:value) { uuid_urn }
      it { is_expected.to be_truthy }
    end

    context 'with non-matching string' do
      let(:value) { '37475665tggg' }
      it { is_expected.to be_falsy }
    end
  end

  describe 'Kernel#UUID4' do
    subject { UUID4(uuid_str) }
    it { is_expected.to be_a UUID4 }
    it { is_expected.to eq uuid }
  end

  describe 'Kernel#UUID' do
    subject { UUID(uuid_str) }
    it { is_expected.to be_a UUID4 }
    it { is_expected.to eq uuid }
  end

  describe 'eql?' do
    subject { uuid }
    it { is_expected.to eql UUID(uuid_str) }
  end

  describe 'hash' do
    subject { uuid.hash }
    it { is_expected.to equal UUID(uuid_str).hash }
  end

  describe 'hash equality' do
    let(:object) { Object.new }
    subject { { uuid => object } }

    it { is_expected.to have_key uuid }
    it { is_expected.to have_key UUID(uuid_str) }
    it { is_expected.to include uuid }
    it { is_expected.to include UUID(uuid_str) }
    it { expect(subject[uuid]).to equal object }
  end
end
