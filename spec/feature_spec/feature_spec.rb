require 'bitmap_editor.rb'

ALL_COMMANDS_EXAMPLE_FILE = 'spec/feature_spec/test_files/' \
  'all_commands_example.txt'.freeze
ALL_COMMANDS_EXAMPLE_OUTPUT = "OOOOO\nOOZZZ\nAWOOO\nOWOOO\n" \
  "OWOOO\nOWOOO\n".freeze

INIT_AND_SHOW_EXAMPLE_FILE = 'spec/feature_spec/test_files/' \
  'init_and_show.txt'.freeze
INIT_AND_SHOW_EXAMPLE_OUTPUT = "OOO\nOOO\nOOO\nOOO\n".freeze

describe 'Feature tests' do
  let(:bitmap_editor) { BitmapEditor.new }

  xit 'creates a bitmap cycling through all command types on a file' do
    expect { bitmap_editor.run ALL_COMMANDS_EXAMPLE_FILE }
      .to output(ALL_COMMANDS_EXAMPLE_OUTPUT).to_stdout
  end

  it 'creates and shows a blank bitmap' do
    expect { bitmap_editor.run INIT_AND_SHOW_EXAMPLE_FILE }
      .to output(INIT_AND_SHOW_EXAMPLE_OUTPUT).to_stdout
  end
end
