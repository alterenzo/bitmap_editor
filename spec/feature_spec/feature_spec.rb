require 'bitmap_editor.rb'

TEST_DIR = 'spec/feature_spec/test_files/'.freeze

ALL_COMMANDS_EXAMPLE_FILE = 'all_commands_example.txt'.freeze
ALL_COMMANDS_EXAMPLE_OUTPUT = "OOOOO\nOOZZZ\nAWOOO\nOWOOO\n" \
  "OWOOO\nOWOOO\n".freeze

INIT_AND_SHOW_EXAMPLE_FILE = 'init_and_show.txt'.freeze
INIT_AND_SHOW_EXAMPLE_OUTPUT = "OOO\nOOO\nOOO\nOOO\n".freeze

INIT_AND_COLOR_EXAMPLE_FILE = 'init_and_color.txt'.freeze
INIT_AND_COLOR_EXAMPLE_OUTPUT = "BOO\nOOO\nOOO\nOOA\nOOO\n".freeze

CLEAR_EXAMPLE_FILE = 'clear.txt'.freeze
CLEAR_EXAMPLE_OUTPUT = "OOO\nOOO\nOOO\n"

describe 'Feature tests' do
  let(:bitmap_editor) { BitmapEditor.new }

  it 'creates a bitmap cycling through all command types on a file' do
    run_feature_test(ALL_COMMANDS_EXAMPLE_FILE, ALL_COMMANDS_EXAMPLE_OUTPUT)
  end

  it 'creates and shows a blank bitmap' do
    run_feature_test(INIT_AND_SHOW_EXAMPLE_FILE, INIT_AND_SHOW_EXAMPLE_OUTPUT)
  end

  it 'creates a bitmap and colors two pixels' do
    run_feature_test(INIT_AND_COLOR_EXAMPLE_FILE, INIT_AND_COLOR_EXAMPLE_OUTPUT)
  end

  it 'creates a bitmap, colors a line and then clears it' do
    run_feature_test(CLEAR_EXAMPLE_FILE, CLEAR_EXAMPLE_OUTPUT)
  end

  def run_feature_test(filename, output)
    expect { bitmap_editor.run TEST_DIR + filename }.to output(output).to_stdout
  end
end
