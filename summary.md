# Gym Training App - Session Summary

## Project Overview
A Rails 8 application designed for tracking gym routines and workout sessions, with a central AI-driven chat interface for managing workout plans.

## Tech Stack
- **Backend:** Ruby on Rails 8.0.4, SQLite.
- **Frontend:** Bulma CSS, Hotwire (Turbo & Stimulus).
- **AI Integration:** `ruby_llm` gem using `gemini-2.5-flash` via Google Vertex AI.
- **Testing:** RSpec.
- **Icons:** `lucide-rails`.

## Core Features Implemented

### 1. Authentication & Persistence
- **Identifier-based Login:** Users enter a unique ID (e.g., "carlows"). No passwords.
- **Current Helper:** Uses `ActiveSupport::CurrentAttributes` to manage the session.

### 2. Exercise Library
- **Data Source:** Imported nearly 800 exercises from `megaGymDataset.csv`.
- **Rake Task:** `lib/tasks/exercises.rake` handles ingestion.
- **Seed System:** Database is fully seeded with names, descriptions, and muscle groups.

### 3. AI-Driven Routine Management
- **Chat Interface:** Reactive UI using Turbo Streams for real-time assistant responses.
- **Tool-Calling Architecture:** The AI uses 9 custom tools to manipulate the database:
    - `CreateRoutineTool`, `AddDayToRoutineTool`, `SearchExerciseTool`, `AddExerciseToRoutineDayTool`.
    - `ArchiveRoutineTool` (Soft-delete), `ListUserRoutinesTool` (Context awareness).
    - `UpdateRoutineExerciseTool`, `RemoveExerciseFromRoutineTool`, `RemoveDayFromRoutineTool`.
- **Auto-Scroll:** Stimulus controller (`chat_scroll_controller.js`) ensures the chat view stays at the bottom.

### 4. Workout Execution
- **Logging Interface:** Mobile-responsive view for entering sets, reps, and weight (in kg).
- **Progressive Overload:** Displays "Last Session" results for each exercise during logging.
- **History:** Dashboard lists active routines and recent workout sessions.

## Data Model Highlights
- `User` has one `Chat`, many `Routines`, and many `Sessions`.
- `Routine` has many `RoutineDays`.
- `RoutineDay` has many `RoutineExercises` (belongs to `Exercise`).
- `Session` tracks performance per `Exercise` via `SessionExercise`.
- `Chat`, `Message`, `Model`, and `ToolCall` handle the AI persistence via `ruby_llm`'s `acts_as_chat` API.

## Critical Setup / Environment
- **Provider:** Vertex AI (using Google Application Default Credentials).
- **Env Vars Required:** `GOOGLE_CLOUD_PROJECT`, `GOOGLE_CLOUD_LOCATION`.
- **Current Model:** `gemini-2.5-flash`.

## How to Verify
- Run `./bin/dev`.
- Login as "carlows".
- Visit `/chat` to manage routines.
- Visit `/` (Dashboard) to see routines and log sessions.
