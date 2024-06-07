#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "\nWelcome to My Salon, how can I help you?"
SERVICE_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\n1) cut\n2) color\n3) perm\n4) style\n5) trim"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) SERVICE_LIST ;;
    2) SERVICE_LIST ;;
    3) SERVICE_LIST ;;
    4) SERVICE_LIST ;;
    5) SERVICE_LIST ;;
    *) SERVICE_MENU "I could not find that service. What would you like today?" ;;
  esac
}
SERVICE_LIST(){
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  NAME_OF_CUSTOMER=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $NAME_OF_CUSTOMER ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  fi
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
  read SERVICE_TIME
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(service_id,customer_id,time) VALUES($SERVICE_ID_SELECTED,$CUSTOMER_ID,'$SERVICE_TIME')")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo -e "I have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}
SERVICE_MENU
