#import "@preview/adaptable-pset:0.2.0": *

// Feel free to omit any of the below, just set it to "" and it won't show
#let title = "HW1"
#let author = "Dawson Zhang"
#let collaborators = []
#let course-id = "ECE 351K: Probability and Random Processes"
#let instructor = "Prof. Vivek Telang"
#let semester = "Summer 2026"
#let due-time = ""

#show: homework.with(
  title: title,
  author: author,
  collaborators: collaborators,
  course-id: course-id,
  instructor: instructor,
  semester: semester,
  due-time: due-time,

  // Optional setting to change the paper size depending on region
  // (Defaults to A4)
  // paper-size: "us-letter", 
)

// Numbering
#set enum(numbering: "a)")

// Enable to get a latex-like look
// #set text(font: "New Computer Modern")

// #prob(title: "", color: green)[content goes here]
// Default color is green, can be changed to black if you want to print
// Note that title is optional, it can be removed if you just don't set it to anything (just do #prob[content])
