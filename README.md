![Build Status](https://travis-ci.org/alterenzo/bitmap_editor.svg?branch=master)

# Bitmap editor

Simple ruby application that creates a representation of a bitmap, based on some
instructions found on a file.

A bitmap is represented with a matrix of capital letters, each one assumed to be a color.

Instructions are passed in a text file, having one instruction per line.

## Supported Commands:

* Initialize bitmap
* Color single pixel
* Draw horizontal line
* Draw vertical line
* Clear bitmap
* Show bitmap

### Initialize bitmap

The command is 'I' and it has to have to arguments, representing the dimensions of the bitmap.
Dimensions must be between 1 and 250 (inclusive). The resulting bitmap will be filled with the default color, white, represented with an 'O'

__Example:__ 'I 10 20' will create a 10x20 bitmap

### Color single pixel

The instruction must start with a 'L' and it must be followed by the coordinates of the pixel and the desired color.
Coordinates must be within bounds of the bitmap, and the color must be an uppercase letter..

__Example:__ 'L 7 15 D' will color the pixel at coordinates 7, 15 with the color 'D'

### Draw horizontal line

The instruction starts with an 'H' and it is followed by the two horizontal coordinates, the row number and then the color.

__Example:__ 'H 1 3 6 R' will color the pixels from 1 to 3 (inclusive) on the sixth row, with the color 'R'

### Draw vertical line

Starts with 'V' followed by the column number, vertical coordinates and the color.

__Example:__ 'V 1 3 6 R' will color the pixels from 3 to 6 (inclusive) on the first column, with the color 'R'

### Clear bitmap

It will reset the color of the entire bitmap back to white ('O'). The command is 'C'

__Example:__ 'C'

### Show bitmap

Given with 'S', it will output a representation of the bitmap to the console.

__Example:__ 'S'

## Tests

To run the tests, simply install all the gems with bundler, and run rspec

```
>bundle install
>rspec
```

# Running

`>bin/bitmap_editor examples/show.txt`
