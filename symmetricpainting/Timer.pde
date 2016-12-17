class Timer {
int savedTime; // 计时器何时开始
int passedTime;
Timer() {

}

// Starting the timer
void start() {
// 当计时器开启，它将当前时间以毫秒存储下来
savedTime = millis();

}

int nowTime()
{
  passedTime = millis()- savedTime;
 // println(passedTime/1000);
 return passedTime;
}
}