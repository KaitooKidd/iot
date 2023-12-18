#include <PubSubClient.h>
#include <ESP8266WiFi.h>
#include <DHT.h>
#include <Wire.h>
#include <BH1750.h>
#include <ArduinoJson.h>

const char* ssid = "P 7.1";      
const char* password = "23456789";
const char* mqttServer = "192.168.71.101";
const int mqttPort = 1883;

const char* mqttTopic = "iot";
const char* relayTopic = "relay/control";
const char* relayTopic2 = "relay2/control";
const char* autoTopic = "auto/control";

WiFiClient espClient;
PubSubClient client(espClient);

#define DHTPIN D4 // Sử dụng cổng D4 cho kết nối với DHT11
#define RELAY1 D5 // RELAY1 connected to  GPIO0
#define RELAY2 D6
#define DHTTYPE DHT11 // Loại cảm biến (DHT11 hoặc DHT22)
DHT dht(DHTPIN, DHTTYPE);
//===============================================================
BH1750 lightMeter;
int cb = A0;      //Chân cảm biến ở chân Analog: A0
int doc_cb, TBcb;
float doam;
float nhietdo;
float cuong_do_as;
int do_am_dat;
String autoMode="ON";
String lightStatus;
String pumpStatus;

void setup() {
  Serial.begin(9600);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");

  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);

   //========================Cảm biển DHT=======================================

    dht.begin();// cảm biến dht
        //=========================Cảm biến cường độ ánh sáng======================================
  Wire.begin();
  lightMeter.begin();
    //===========================Cảm biến độ ấm đất====================================

        pinMode (cb, INPUT);        //Tín hiệu vào từ cảm biến

 
  pinMode(RELAY1,OUTPUT);
    pinMode(RELAY2,OUTPUT);

  digitalWrite(RELAY1, LOW);
  lightStatus="ON";
   digitalWrite(RELAY2, LOW);
  pumpStatus="ON";
   connectToMQTT();
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.println("Message received: ");
  Serial.println(topic);

  // Convert payload to string
  String message;
  for (int i = 0; i < length; i++) {
    message += (char)payload[i];
  }

  if (String(topic) == relayTopic) {
    // Control the relay based on the message received
    if (message == "ON") {
      digitalWrite(RELAY1, LOW);
      pumpStatus="ON";
    } else if (message == "OFF") {
      digitalWrite(RELAY1, HIGH);
      pumpStatus="OFF";
    }
  }

  if (String(topic) == relayTopic2) {
    // Control the relay based on the message received
    if (message == "ON") {
      digitalWrite(RELAY2, LOW);
      lightStatus="ON";
    } else if (message == "OFF") {
      digitalWrite(RELAY2, HIGH);
      lightStatus="OFF";
    }
  }
  
  if (String(topic) == autoTopic) {
    // Control the relay based on the message received
    if (message == "ON") {
      autoMode="ON";
      Serial.println("Auto Mode ON");
    } else if (message == "OFF") {
      Serial.println("Auto Mode OFF");
      autoMode="OFF";
    }
  }
}

void doDHT(){
    delay(2000); // Đợi một khoảng thời gian trước khi đọc dữ liệu

  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();
  
  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("Lỗi đọc dữ liệu từ cảm biến DHT11");
  } else {
    Serial.print("Nhiệt độ: ");
    Serial.print(temperature);
    Serial.println(" °C");
    Serial.print("Độ ẩm: ");
    Serial.print(humidity);
    Serial.println(" %");
  doam=humidity;
  nhietdo=temperature;
  }
}

void doCuongDoSang(){
    float lux = lightMeter.readLightLevel();
cuong_do_as=lux;

  Serial.print("Cường độ ánh sáng: ");
  Serial.print(lux);
  Serial.println(" lx");

  if (lux < 1 && autoMode == "ON") {
    digitalWrite(RELAY2, LOW); // Bật RELAY2
    lightStatus="ON";
  } else if (lux >= 1 && autoMode == "ON") {
    digitalWrite(RELAY2, HIGH); // Tắt RELAY2
    lightStatus="OFF";
  }

  delay(1000); // Đợi 1 giây trước khi đọc lại giá trị ánh sáng
}

void doDoAmDat(){
     for(int i=0;i<=9;i++)   /*Chúng ta sẽ tạo một hàm for để đọc 10 lần giá trị cảm biến, 
                            sau đó lấy giá trị trung bình để được giá trị chính xác nhất.*/
        {
          doc_cb += analogRead(cb);     
        }
    TBcb=doc_cb/10;     //Tính giá trị trung bình
    
    
    int phantramao = map(TBcb, 0, 1023, 0, 100);    //Chuyển giá trị Analog thành giá trị %
    int phantramthuc = 100 - phantramao;              //Tính giá trị phần trăm thực, chuyển điện thế khô thành ẩm

     do_am_dat = phantramthuc;

    
    Serial. print("analog: "); Serial. print(TBcb); Serial.print(" "); Serial. print("~"); Serial.print(" "); 
    Serial.print(phantramthuc); Serial.println('%');
    delay (500);
    doc_cb=0;
    
    if ( phantramthuc >= 10 && autoMode == "ON")         //Nếu phần trăm thực lớn hơn hoặc = 30%
      
      {
        Serial.println("OFF");
        digitalWrite (RELAY1, HIGH);    //Thì RELAY1 OFF, không bơm
        pumpStatus="OFF";
      }
    
    else if( phantramthuc < 10 && autoMode == "ON")       //Ngược lại, phần trăm thực nhỏ hơn 30%
      {
        Serial.println("ON");
        digitalWrite (RELAY1, LOW);   //Thì RELAY1 ON, Bơm chạy
        pumpStatus="ON";
      }
  }

void loop() {
  DynamicJsonDocument doc(256);
  
  // Assuming doDHT(), doCuongDoSang(), and doDoAmDat() are your sensor reading functions
  doDHT();
  doCuongDoSang();
  doDoAmDat();

  doc["do_am"] = doam;
  doc["nhiet_do"] = nhietdo;
  doc["do_am_dat"] = do_am_dat;
  doc["cuong_do_anh_sang"] = cuong_do_as;
  doc["light_status"]=lightStatus;
  doc["pump_status"]=pumpStatus;
  doc["autoMode"]=autoMode;


  String jsonString;
  serializeJson(doc, jsonString);

  if (!client.connected()) {
    connectToMQTT();
  }

  // Publish JSON string to MQTT topic
  client.publish(mqttTopic, jsonString.c_str());
  Serial.println("================SEND DATA================");

  client.loop();

}




void connectToMQTT() {
  while (!client.connected()) {
    Serial.println("Attempting MQTT connection...");
    if (client.connect("ArduinoClient")) {
      Serial.println("Connected to MQTT");
            client.subscribe(relayTopic);
            client.subscribe(relayTopic2);
            client.subscribe(autoTopic);

    } else {
      Serial.print("Failed, rc=");
      Serial.print(client.state());
      Serial.println(" Retrying in 5 seconds...");
      delay(5000);
    }
  }
}
