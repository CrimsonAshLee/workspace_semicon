// #include <stdio.h>  // IO 관련 헤더파일 불러옴 전처리기
// #define APPLE 10 // 앞으로 APPLE는 10(숫자)이야 !
// #define NAME "사과" // 문자열

// 한줄 주석(설명)
/* 여기부터 주석시작
~~~~~~~~~~~~
여기까지 주석*/

// c언어 시작인 메인함수 시작
// int main()
// {
//     char ch;
//     int num;
//     double x;
    
//     int a = 20;
//     int b = 0xff;

//     // 터미널에 helloworld 프린트
//     printf("Hello World \n\n\n");
//     printf("%s, %d, %c, %d%%, %x, %d \n\n\n",NAME,APPLE,'a', a, b, b);
//     // \n 줄바꿈
//     // \r 커서를 맨 앞으로
//     // /t 탭(4칸 띄우기)

//     printf("char 형의 바이트크기 : %d \n", sizeof(char));
//     printf("short 형의 바이트크기 : %d \n", sizeof(short));
//     printf("long 형의 바이트크기 : %d \n", sizeof(long));
//     printf("float 형의 바이트크기 : %d \n", sizeof(float));
    
//     printf("ch 형의 바이트크기 : %d \n", sizeof(ch));
//     printf("num 형의 바이트크기 : %d \n", sizeof(num));
//     printf("x 형의 바이트크기 : %d \n", sizeof(x));
//     return 0;     
// }

/* c언어의 키워드 32개(예약어)
 * 서식지정자
*/

// sizeof() 연산자 - 괄호안에 있는것을 바이트크기로 반환
// int num
// 영문자, 숫자, 특수문자(_) : 변수명 선언시
// 첫글자는 숫자는 불가능, 영문자, 특수문자 가능, 대소문자 구별해야함
// 변수명의 키워드(예약어) 불가

// 카멜표기법 => int manAge : 첫단어는 소문자, 결합되는 단어는 대문자로 시작
// 스네이크표기법 => int man_Age : 단어사이는 언더스코어로 연결
// 파스칼 표기법 => int ManAge : 모든단어를 대문자로 시작
// 헝가리안표기법 => int iManName : 변수명앞에 데이터형의 약자를 넣어줌

// 변수의 초기화 
// 변수를 선언하고 초기화하지 않으면 지역변수는 쓰레기값임

// #include <stdio.h>  

// // 전역변수와 정적변수는 자동으로 초기화, 지역변수는 초기화 x
// int g; // 전역변수 

// int main()
// {
//     static int num; // 정적변수 
//     int price = 0; // 지역변수
//     int amount = 0;
//     int totalPrice = 0;

//     printf("%d\n", price);
//     printf("%d\n", g);
//     printf("%d\n", num);
   
//     price = 100;

//     printf("amount = %d, price = %d\n", amount, price);
//     printf("수량을 넣으시오 : ");
//     scanf("%d", &amount);

//     totalPrice = amount * price;/ #include <stdio.h>  // IO 관련 헤더파일 불러옴 전처리기
// #define APPLE 10 // 앞으로 APPLE는 10(숫자)이야 !
// #define NAME "사과" // 문자열

// 한줄 주석(설명)
/* 여기부터 주석시작
~~~~~~~~~~~~
여기까지 주석*/

// c언어 시작인 메인함수 시작
// int main()
// {
//     char ch;
//     int num;
//     double x;
    
//     int a = 20;
//     int b = 0xff;

//     // 터미널에 helloworld 프린트
//     printf("Hello World \n\n\n");
//     printf("%s, %d, %c, %d%%, %x, %d \n\n\n",NAME,APPLE,'a', a, b, b);
//     // \n 줄바꿈
//     // \r 커서를 맨 앞으로
//     // /t 탭(4칸 띄우기)

//     printf("char 형의 바이트크기 : %d \n", sizeof(char));
//     printf("short 형의 바이트크기 : %d \n", sizeof(short));
//     printf("long 형의 바이트크기 : %d \n", sizeof(long));
//     printf("float 형의 바이트크기 : %d \n", sizeof(float));
    
//     printf("ch 형의 바이트크기 : %d \n", sizeof(ch));
//     printf("num 형의 바이트크기 : %d \n", sizeof(num));
//     printf("x 형의 바이트크기 : %d \n", sizeof(x));
//     return 0;     
// }

/* c언어의 키워드 32개(예약어)
 * 서식지정자
*/

// sizeof() 연산자 - 괄호안에 있는것을 바이트크기로 반환
// int num
// 영문자, 숫자, 특수문자(_) : 변수명 선언시
// 첫글자는 숫자는 불가능, 영문자, 특수문자 가능, 대소문자 구별해야함
// 변수명의 키워드(예약어) 불가

// 카멜표기법 => int manAge : 첫단어는 소문자, 결합되는 단어는 대문자로 시작
// 스네이크표기법 => int man_Age : 단어사이는 언더스코어로 연결
// 파스칼 표기법 => int ManAge : 모든단어를 대문자로 시작
// 헝가리안표기법 => int iManName : 변수명앞에 데이터형의 약자를 넣어줌

// 변수의 초기화 
// 변수를 선언하고 초기화하지 않으면 지역변수는 쓰레기값임

// #include <stdio.h>  

// // 전역변수와 정적변수는 자동으로 초기화, 지역변수는 초기화 x
// int g; // 전역변수 

// int main()
// {
//     static int num; // 정적변수 
//     int price = 0; // 지역변수
//     int amount = 0;
//     int totalPrice = 0;

//     printf("%d\n", price);
//     printf("%d\n", g);
//     printf("%d\n", num);
//     printf("합계 = %d 원 \n\n\n", totalPrice);
// }

// #include <stdio.h>  

// 산술연산자
// +, -, *,/, %, ++. --
// int main()
// {
//     int a = 39;
//     int b = 17;
//     int res; 
    
//     res = a + b;
//     printf("a + b = %d\n",res);

//     res = a - b;
//     printf("a - b = %d\n",res);

//     res = a * b;
//     printf("a * b = %d\n",res);

//     res = a / b;
//     printf("a / b = %d\n",res);

//     res = a % b;
//     printf("a %% b = %d\n\n",res);

//     return 0;
// }

// 대입연산자
// = : 우측에 있는 값을 좌측에 대입
// +=,-=,*=,/=,%=

// 관계연산자
// ==, !=, >, <, >=, <=


// 논리연산자 
// && = and, || = or, ! = not


// int main()
// {
//     int month;
    
//     printf("몇 월??? : \n");
//     scanf("%d", &month);
    
//     if(month >= 6 && month <= 8)
//     {
//         printf("성수기 요금 적용 \n");
//     }  // and
   
//     if (month < 6 || month > 8)
//     {
//         printf("일반 요금 적용 \n");
//     }  // or
// }

// 삼항연산자 (또는 조건연산자)
// expression 1 ? expression2: expression3
// 만약 expression1이 참이면 expression2가 수행, 참이 아니면 expression3이 수행

// 특수연산자 
// sizeof() : 소괄호안에 있는 것을 바이트크기로 반환
// & : 변수가 저장된 메모리상의 주소값을 반환
// * : 변수의 포인터

// 비트연산자 
// &, |, ^, ~, <<, >>
