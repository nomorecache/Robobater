/*  1.8.11
    User input turns on/off corresponding Servo   */

//Create an array to hold data.
char serInString[100];

//Global funcs
void readSerialString(char *strArray);
void showStatement(int a, int b);
int parseSerialString(char *serialInputArray);

//Global vars
//Array to hold data value of each servo
int srvVal[6];

// Assign servo names to PWM pins
int srv[6] = {3, 5, 6, 9, 10, 11}; 


void setup() 
{
	//Initialize serial interface
	Serial.begin(9600);
	delay(500);

	//Initialize pins as outputs
	for(int i=0; i<6; i++)
	{
		pinMode(srv[i], OUTPUT);
	}

	//Display the following message on serial monitor
	Serial.println("Enter an 18 character string of data");
 }
 
 
void loop()
{
	//Read the serial port and create a string out of what you read
	//Puts it into serInString
	readSerialString(serInString);
	//Serial.println(serInString);
	//parseSerialString(serInString);
}

//read a string from the serial and store it in an array
//you must supply the array variable
void readSerialString (char *strArray) 
{
	int i = 0;
	if(!Serial.available())
	{
		return;
	}
	while (Serial.available())
	{
		strArray[i] = Serial.read();
		i++;
	}
	Serial.println(strArray);
}

void showStatement(int a, int b)
{
	Serial.print("The value of servo ");
	Serial.print(a);
	Serial.print(" is ");
	Serial.print(b);
	Serial.println(".");
}


int *parseSerialString(char *serialInputArray)
{
	int valueArray[6];
	int stringPosition = 0;
	
	//temporary character array representing a single value
	char temp[3];
	
	//fill up the value array
	for(int valueArrayIndex = 0; valueArrayIndex<6; valueArrayIndex++)
	{
		//fill up a value (three characters)
		for(int j = 0; j<3; j++)
		{
			temp[j]=serialInputArray[stringPosition];
			//go to next character
			stringPosition++;
		}
		//convert character string, temp, to integer and store in value array
		valueArray[valueArrayIndex] = atoi(temp);
	}
	return valueArray;
}

	