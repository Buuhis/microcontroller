#include <stdio.h>
#include <mega16.h>
#include <delay.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define MAX_STRING_LENGTH 20
#define ADC_VREF_TYPE 0x00

volatile int ticks = 0;
unsigned long tram, chuc, dvi;
unsigned long adc_out;
unsigned long nhiet_do;
unsigned int count;
char receivedData[MAX_STRING_LENGTH];
int index = 0;

void uart_char_send(unsigned char chr);  //chuong trinh con phat mot ky tu
void uart_string_send(unsigned char *txt);  //chuong trinh con phat mot chuoi ky tu
void check_string(char *receivedData);

interrupt [EXT_INT0] void ext_int0_isr(void);  // External Interrupt 0 service routine
interrupt [TIM1_COMPA] void timer1_compa_isr(void);
interrupt [USART_RXC] void usart_rx_isr(void); 

unsigned int read_adc(unsigned char adc_input);  // Read the AD conversion result


void main(void)
{
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=T 
PORTB=0x00;
DDRB=0x02;

// Port C initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTC=0x00;
DDRC=0xFF;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=Out 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=0 
PORTD=0x00;
DDRD=0x02;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 8000.000 kHz
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: On
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x0C;
TCNT1H=0x00;
TCNT1L=0x00;
OCR1BH=0x00;
OCR1BL=0x00;


// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x10;

// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Rising Edge
// INT1: Off
// INT2: Off
GICR|=0x40;
MCUCR=0x03;
MCUCSR=0x00;
GIFR=0x40;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=0x98;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x33;

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AREF pin
// ADC Auto Trigger Source: ADC Stopped
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x83;

// Global enable interrupts
#asm("sei")


while (1)
    {
        
        adc_out = read_adc(0);
        nhiet_do = adc_out*500/1023;
        chuc = nhiet_do/10;
        dvi = (nhiet_do%10);
         
         
        //uart_string_send("nhiet do la:");
        uart_char_send(chuc + 0x30);
        uart_char_send(dvi + 0x30);
        uart_string_send("\r\n");
         
        delay_ms(200);
             
    }
}




void uart_char_send(unsigned char chr)
{
    while (!(UCSRA & (1<<UDRE)))   //cho den khi bit UDRE = 1
    {
        
    }; 
    UDR = chr;
}


void uart_string_send(unsigned char *txt)
{
    unsigned char n, i;
    n = strlen(txt); //dem so ky tu
        for (i = 0; i < n; i++)
        {
            uart_char_send(txt[i]); //phat du lieu
        }
}



interrupt [EXT_INT0] void ext_int0_isr(void)
{    
    count++;
    
    tram = count/ 100;
    chuc = (count % 100)/ 10;
    dvi = count % 10;   

    
    uart_string_send("count:");
    uart_char_send(tram + 0x30);
    uart_char_send(chuc + 0x30);
    uart_char_send(dvi + 0x30);
    
    uart_string_send("\r\n");        
}


interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
    PORTB ^= (1 << PORTB1);
}


interrupt [USART_RXC] void usart_rx_isr(void)
{
    char data = UDR;
    uart_char_send(data);
    
    if (data == '\n' || data == '\r')
    {
        receivedData[index] = '\0';
        check_string(receivedData);
        
        index = 0;
    }
    else
    {
        if (index < MAX_STRING_LENGTH - 1)
        {
            receivedData[index++] = data;
        }
    }
}



void check_string(char *receivedData)
{
    if (strstr(receivedData, "led1 on") != NULL)
    {
        PORTC |= 0b00000001; 
    }
    if (strstr(receivedData, "led1 off") != NULL)
    {
        PORTC &= ~0b00000001; 
    }
    if (strstr(receivedData, "led2 on") != NULL)
    {
        PORTC |= 0b00000010;
    }
    if (strstr(receivedData, "led2 off") != NULL)
    {
        PORTC &= ~0b00000010;
    }
    if (strstr(receivedData, "led3 on") != NULL)
    {
        PORTC |= 0b00000100;
    }
    if (strstr(receivedData, "led3 off") != NULL)
    {
        PORTC &= ~0b00000100;
    }
    if (strstr(receivedData, "led4 on") != NULL)
    {
        PORTC |= 0b00001000;
    }
    if (strstr(receivedData, "led4 off") != NULL)
    {
        PORTC &= ~0b00001000;
    }
    if (strstr(receivedData, "led5 on") != NULL)
    {
        PORTC |= 0b00010000;
    }
    if (strstr(receivedData, "led5 off") != NULL)
    {
        PORTC &= ~0b00010000;
    }
    if (strstr(receivedData, "led6 on") != NULL)
    {
        PORTC |= 0b00100000;
    }
    if (strstr(receivedData, "led6 off") != NULL)
    {
        PORTC &= ~0b00100000;
    }
    if (strstr(receivedData, "led7 on") != NULL)
    {
        PORTC |= 0b01000000;
    }
    if (strstr(receivedData, "led7 off") != NULL)
    {
        PORTC &= ~0b01000000;
    }
    if (strstr(receivedData, "led8 on") != NULL)
    {
        PORTC |= 0b10000000;
    }
    if (strstr(receivedData, "led8 off") != NULL)
    {
        PORTC &= ~0b10000000;
    }


    if (strncmp(receivedData, "set time", 8) == 0)
    {
        ticks = atoi(receivedData + 9);

        ticks = (ticks < 5) ? ticks : 5;
        ticks = (ticks > 0.5) ? ticks : 0.5;

        // Convert time to ticks 
        ticks = (int)floor(ticks * 8000000 / 256);

        OCR1AH = (unsigned char)(ticks >> 8);
        OCR1AL = (unsigned char)ticks;
    }
}



unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}


