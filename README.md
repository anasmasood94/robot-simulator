# Robot Simulator

Robot simulator is a Ruby on Rails app that simulates the movements of a robot on a table of 5 units X 5 units of deminesions. Robots can move on the table in a given direction and the program makes sure that it does not fall off the table.

## Installation

Clone the repo for GitHub and run in the project directory install bundler.

```bash
gem install bundler
```

After installing the bundler run this command to install the required gems:

```bash
bundle install
```
Install all the required yarn packages using this command:

```bash
yarn install
```

## Run the server
Now that the project setup is complete we are ready to run the server and use our app, use this command to start the rails server:

```bash
rails s
```

## Running Test Cases
Test cases are written using `minitest` and you can run these test cases using this command:

```bash
rails test
```

## Using the UI
The UI provides a simple interface and you can place the robot by entering its position and direction. After adding the position you can move the robot in the added direction by using the MOVE command or rotate it left or right by using respective buttons. Then using the execute button you can run the simulations. A result is only shown if the report button was pressed at least once.

## Sample Test Cases
Following are few sets of commands that you can use and see the results:

### Sample 1
```bash
PLACE(0, 1, NORTH)
MOVE
MOVE
LEFT
MOVE
REPORT
```
### Output
```bash
Output: 0, 3, WEST
```

### Sample 2
```bash
PLACE(0, 0, NORTH)
MOVE
MOVE
REPORT
MOVE
REPORT
```
### Output
```bash
Output: 0, 2, NORTH
Output: 0, 3, NORTH
```
