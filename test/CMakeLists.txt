message(STATUS "building tests")

file(GLOB files "test_*.cpp")

foreach(file ${files})
	string(REGEX REPLACE "(^.*/|\\.[^.]*$)" "" file_without_ext ${file})
	add_executable(${file_without_ext} ${file})
	add_test(${file_without_ext} ${file_without_ext})
endforeach()