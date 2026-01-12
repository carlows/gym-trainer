# PRD: Gym Training App

## Overview
A web-based gym training application for tracking routines and workout sessions.

## Tech Stack
- **Framework:** Ruby on Rails
- **Frontend:** Bulma (CSS), Stimulus.js, Hotwire (Turbo)
- **Database:** SQLite
- **Background Jobs:** solid_queue
- **LLM:** RubyLLM gem (Gemini 3.0 Flash)
- **Tests**: RSpec

## Core Requirements

### 1. Authentication (Simplified)
- **Login Screen:** Users enter a unique identifier (e.g., "carlows").
- **No Password:** Authentication is based solely on the identifier.
- **Persistence:** Routines and sessions are associated with this identifier.

### 2. Exercise Library
- A comprehensive list of all possible gym exercises.
- We should download the dataset from the following kaggle: https://www.kaggle.com/datasets/niharika41298/gym-exercise-data/data
- This dataset must be imported into the Exercise table.
- We should create a rake task that performs the import.
- We also must seed the database with the exercises with the seed command.

### 3. Routine Management (editing routines)
- **Add days to the routine:** Add days to the routine (e.g: Monday, Wednesday, Friday)
- **Exercise Selection:** Add exercises from the library to the routine days
- **Targets:** Specify the number of sets and repetitions for each exercise in the routine.
- No routine management is allowed unless its via the chat interface.

### 3.1 Creating new routines
- **Create Routine:** Define a named routine (e.g: "Push/Pull/Legs")
- **Add days to the routine:** Add days to the routine (e.g: Monday, Wednesday, Friday)
- **Exercise Selection:** Add exercises from the library to the routine days
- **Targets:** Specify the number of sets and repetitions for each exercise in the routine.
- Adding the routine can only be done via a chat interface. This is where rubyllm comes into play.
- You talk to the chat about what exercises you want to perform and on which days. The conversation should be fluid.
- I should be able to ask the LLM to create a new routine called "Push/Pull/Legs" on Monday, Wednesday, Friday. and add certain exercises to each day.
- The LLM must recognize the user intent and create and edit the routine, routine days and exercises accordingly.

### 3.2 Deleting routines and editing exercises
- The chat should allow to delete a routine without deleting the associated sessions. This should remove the routine from the list but not the data/history.
- The chat should allow to edit days and exercises from existing routines, you just need to specify the id or routine name.

### 4. Workout Sessions
- **Start Session:** Select a routine to perform for the day.
    - After selecting a routine, you should see the list of exercises to perform for the day.
    - You should be able to see the last session results for each exercise.
- **Logging:** Fill in the actual performance (sets/reps) based on the routine's template.
- **History:** Save completed sessions for future reference.
- The ui for filling the session should be super easy to fill in.

## Data Model

All tables should have a primary key id besides these specified columns.

- `User`: identifier (string)
- `Exercise`: name, description, type, body_part, equipment
- `Routine`: user_id, name
- `RoutineDay`: routine_id, day_of_week
- `RoutineExercise`: routine_id, exercise_id, target_sets, target_reps
- `Session`: user_id, routine_id, completed_at
- `SessionExercise`: session_id, exercise_id, sets, reps

## Non functional Requirements

- We should write tests for our code using RSpec.
- Keep controlers thin.
- Check your work using the chrome MCP server.
- We should have a responsive design that works on iOS devices or desktop browsers.
- A clean design with minimal distractions.
- The chat must scroll down whenever there's some new message.
