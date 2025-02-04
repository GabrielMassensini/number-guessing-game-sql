#!/bin/bash

# Conectar ao banco de dados
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Gerar número secreto
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

# Solicitar nome do usuário
echo "Enter your username:"
read USERNAME

# Verificar se o usuário já existe
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

if [[ -z $USER_ID ]]
then
  # Novo usuário
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
  GAMES_PLAYED=0
  BEST_GAME=0
else
  # Usuário existente
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE user_id=$USER_ID")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE user_id=$USER_ID")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Iniciar o jogo
GUESS_COUNT=0
echo "Guess the secret number between 1 and 1000:"

while true
do
  read GUESS

  # Verificar se o input é um número inteiro
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi

  GUESS_COUNT=$((GUESS_COUNT + 1))

  if [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
  elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  else
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"

    # Atualizar o banco de dados
    GAMES_PLAYED=$((GAMES_PLAYED + 1))
    if [[ $BEST_GAME -eq 0 || $GUESS_COUNT -lt $BEST_GAME ]]
    then
      BEST_GAME=$GUESS_COUNT
    fi
    UPDATE_RESULT=$($PSQL "UPDATE users SET games_played=$GAMES_PLAYED, best_game=$BEST_GAME WHERE user_id=$USER_ID")
    break
  fi
done

########