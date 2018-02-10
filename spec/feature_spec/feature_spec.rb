require 'bitmap_editor.rb'

EXAMPLE_DIR = 'spec/feature_spec/test_files/'.freeze

ALL_COMMANDS_EXAMPLE_FILE = 'all_commands_example.txt'.freeze
ALL_COMMANDS_EXAMPLE_OUTPUT = "OOOOO\nOOZZZ\nAWOOO\nOWOOO\n" \
  "OWOOO\nOWOOO\n".freeze

INIT_AND_SHOW_EXAMPLE_FILE = 'init_and_show.txt'.freeze
INIT_AND_SHOW_EXAMPLE_OUTPUT = "OOO\nOOO\nOOO\nOOO\n".freeze

INIT_AND_COLOR_EXAMPLE_FILE = 'init_and_color.txt'.freeze
INIT_AND_COLOR_EXAMPLE_OUTPUT = "BOO\nOOO\nOOO\nOOA\nOOO\n"

describe 'Feature tests' do
  let(:bitmap_editor) { BitmapEditor.new }

  xit 'creates a bitmap cycling through all command types on a file' do
    expect { bitmap_editor.run EXAMPLE_DIR + ALL_COMMANDS_EXAMPLE_FILE }
      .to output(ALL_COMMANDS_EXAMPLE_OUTPUT).to_stdout
  end

  it 'creates and shows a blank bitmap' do
    expect { bitmap_editor.run EXAMPLE_DIR + INIT_AND_SHOW_EXAMPLE_FILE }
      .to output(INIT_AND_SHOW_EXAMPLE_OUTPUT).to_stdout
  end

  it 'creates a bitmap and colors two pixels' do
    expect { bitmap_editor.run EXAMPLE_DIR + INIT_AND_COLOR_EXAMPLE_FILE }
      .to output(INIT_AND_COLOR_EXAMPLE_OUTPUT).to_stdout
  end
end
