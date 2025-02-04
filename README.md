# Number Guessing Game

Welcome to the **Number Guessing Game**! This is a simple command-line game where you guess a randomly generated number between 1 and 1000. The game keeps track of your progress, including the number of games played and your best performance.

---

## Features

-  **Random Number Generation**: The game generates a random number between 1 and 1000 for you to guess.
-  **User Tracking**: The game saves your username, the number of games played, and your best score (fewest guesses to win).
-  **Interactive Feedback**: The game provides hints ("higher" or "lower") after each guess until you find the correct number.
-  **Input Validation**: The game ensures that your guesses are valid integers.

---

## How to Play

1. **Run the Script**:
   Open your terminal and navigate to the project directory. Run the script using:

   ```bash
   ./number_guess.sh
   ```

2. **Enter Your Username**:
   The game will prompt you to enter a username. If you've played before, it will welcome you back and show your stats. If you're new, it will greet you as a first-time player.

3. **Guess the Number**:
   The game will ask you to guess a number between 1 and 1000. After each guess, it will tell you if the secret number is higher or lower than your guess.

4. **Win the Game**:
   When you guess the correct number, the game will congratulate you and display the number of guesses it took. Your stats will be saved for future games.

---

## Requirements

-  **Bash**: The script is written in Bash and requires a Unix-like terminal.
-  **PostgreSQL**: The game uses a PostgreSQL database to store user information. Make sure PostgreSQL is installed and running on your system.

---

## Setup Instructions

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/your-username/number_guessing_game.git
   cd number_guessing_game
   ```

2. **Set Up the Database**:

   -  Connect to PostgreSQL:
      ```bash
      psql --username=freecodecamp --dbname=postgres
      ```
   -  Create the database:
      ```sql
      CREATE DATABASE number_guess;
      ```
   -  Connect to the database and create the `users` table:
      ```sql
      \c number_guess
      CREATE TABLE users (
          user_id SERIAL PRIMARY KEY,
          username VARCHAR(22) UNIQUE NOT NULL,
          games_played INT DEFAULT 0,
          best_game INT
      );
      ```

3. **Make the Script Executable**:

   ```bash
   chmod +x number_guess.sh
   ```

4. **Run the Game**:
   ```bash
   ./number_guess.sh
   ```

---

## Database Backup

To back up the database, run the following command:

```bash
pg_dump -cC --inserts -U freecodecamp number_guess > number_guess.sql
```

To restore the database from the backup:

```bash
psql -U postgres < number_guess.sql
```

---

## Contributing

If you'd like to contribute to this project, feel free to fork the repository and submit a pull request. Please ensure your code follows the existing style and includes appropriate tests.

---

## License

This project is open-source and available under the [MIT License](LICENSE).

---

Enjoy the game, and happy guessing! 🎉
