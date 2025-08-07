// #include <stdio.h> // IO관련 헤더파일 불러옴 전처리기
// #define APPLE 10 // 앞으로 APPLE이라는 이름을 10으로 사용하겠다.
// #define NAME "사과" // 문자열을 정의할때는 ""로 감싸야함

//한줄 주석(설명)
/* 여러줄 주석
* 여기부터 주석 시작
* 여기도 주석
* 여기까지 주석
*/

// ex1)
// C언어 시작인 메인함수 시작
// int main()
// {
//     char ch; // 문자형 변수 선언
    // int num; // 정수형 변수 선언
//     double x; // 실수형 변수 선언

//     int a = 20;
//     int b = 0xff;

//     // 터미널에 helloworld를 프린트
//     printf("helloworld\n\n\n"); // \n은 줄바꿈
//     printf("%s, %d, %c, %d%%, %x, %d \n\n\n", NAME, APPLE, 'a', a, b, b);
//     // %s : 문자열, %d : 정수형, %c : 문자형, %x : 16진수, %% : %
//     // %f : 실수형, %o : 8진수
//     // %p : 포인터형, %u : unsigned int
//     // \n 줄바꿈
//     // \r 커서를 맨 앞으로
//     // \t 탭 (4칸 띄위기)
// }
// 

// ex2)
    //sizeof() 연산자 -괄호안에 있는것을 바이트크기로 반환
    // int main()
    // {
    //     char ch;
    //     int num;
    //     double x;

    //     printf("char 형의 바이트크기 : % d \n",sizeof(char));
    //     printf("short 형의 바이트크기 : % d \n",sizeof(short));
    //     printf("long 형의 바이트크기 : % d \n",sizeof(long));
    //     printf("float 형의 바이트크기 : % d \n",sizeof(float));

    //     printf("ch 형의 바이트크기 : % d \n",sizeof(ch));
    //     printf("num 형의 바이트크기 : % d \n",sizeof(num));
    //     printf("x 형의 바이트크기 : % d \n",sizeof(x));
    // }
    // C언어에서 변수의 선언과 사용
    // int num
    // 영문자, 숫자, 특수문자(_) : 변수명 선언시
    // 첫글자는 반드시 영문자, 특수문자만 가능
    // c언어는 대/소문자를 구별
    // 변수명에 키워드(예약어) 불가!!

/* 
* c언어의 키워드 32개(예약어)
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

    // 커맬표기법
    // int manAge : 첫단어는 소문자로 시작, 결합되는 단어는 대문자로 시작
    // 스네이크표기법
    // int man_age : 단어사이는 언더스코어로 연결
    // 파스칼 표기법
    // int ManAge : 모든단어를 대문자로 시작
    // 헝가리안표기법
    // int iManName : 변수명앞에 데이타형의 약자를 넣어줌 (마이크로소프트에서 많이 쓰는 방식)

    // 변수의 초기화
    // 변수를 선언하고 초기화 하지 않으면 지역변수는 쓰레기값이다.

    // ex3)
    // #include <stdio.h>
    
    // int g; // 전역변수(global variable) : 함수밖에서 선언된 변수

    // int main()
    // {
    //     int price = 6; // 지역변수(Local variable) : 함수안에서 선언된 변수
    //     static int num; // 정적변수(static variable) : 함수안에서 선언된 변수, 초기화가 안되면 0으로 초기화됨

    //     printf("%d \n", price);
    //     printf("%d \n", g);
    //     printf("%d \n", num);

    // }

    // ex4)
    // {
    //     int amount = 0;       // 내가 사용 할 변수 3개
    //     int price = 0;
    //     int totalPrice = 0;   // 모두 지역 변수기 때문에 0으로 초기화

    //     printf("amount = %d, price = %d \n", amount, price);
    //     // "amount = %d, price = %d \n" 여기 까지 print 할것임.
    //     // amount, price는 초기화로 인데 0 출력

    //     printf("수량을 넣으시오 : ");
    //     scanf("%d", &amount);       // scanf는 출력이 아닌 입력을 받아들임. stdio의 대표적인 예

    //     price = 100;

    //     totalPrice = amount * price;
    //     printf("합계 : %d \n\n\n", totalPrice);
    // }

    // ex5)
    // #include <stdio.h>

    // // 산술연산자
    // // +, -, *, /, %(나머지), ++(증감연산자 : 정수값이 오르거나 빼짐), --
    // // ex) 3 ++ -> 4, 3 -- -> 2
    // int main()
    // {
    //     int a = 39;
    //     int b = 17;
    //     int result; // Q. 이거 왜 지역변수인데 초기화 안해? 라는 의문을 가져야함

    //     result = a + b;
    //     printf("a + b = %d \n", result);

    //     result = a - b;
    //     printf("a - b = %d \n", result);

    //     result = a * b;
    //     printf("a * b = %d \n", result);

    //     result = a / b;
    //     printf("a / b = %d \n", result);  // 39 / 17 = 2.234.. 실수는 인정 안되서 2까지 출력

    //     result = a % b;
    //     printf("a %% b = %d \n", result); // % 출력할 때는 %% 처럼 2개 써줘야한다
    // }

    //#include <stdio.h>

    // 대입연산자
    // = : 우측에 있는 넘을 좌측으로 대입(저장, 입력)
    // +=, -=, *=, /=, %= : 대입연산자와 산술연산자를 결합한 연산자. 복합연산자
    /* ex
    // int a = 3;
    // int b = 4;
    // int c = 0;
    // c = a + b;
    // a += b; 를 자세하게 풀어보면 a = a + b; 이다. 
    // 저장장치라서 가능한 논리이다. 수학이랑 다르다.
    그런데 여기서 a = a + b 이면 3 = 3 + 4 인데 
    3 + 4를 연산한 7을  3 = 에 덮어 씌워서 7 = 3 + 4 를 만든다
    */

    // 관계연산자
    // ==(같다), !=(같지않다), >(크다), <(작다), >=(크거나 같다), <=(작거나 같다)

    // 논리연산자
    // && 두개의 값이 true일때 true           : AND
    // || 두개의 값중 하나라도 true일때 true    : OR
    // ! true이면 false, false면 true       : NOT


    // ex6)
    // #include <stdio.h>

    // int main()
    // {
    //      int month;   // 변수 선언 
    //      // int month = 0; 초기화 안해줬지만 해줘도 상관 없음. 바로 이어서 쓰기때문
    //      printf("몇 월??? : \n");
    //      scanf("%d", &month);

    //      if(month >= 6 && month <= 8) // AND 6, 7, 8
    //      {                            
    //         printf("성수기 요금 적용 \n");
        
    //      }
    //     // 이 조건을 만족하면 아래 printf가 실행되고 
    //     // 조건을 만족하지 못하면 위의 if{}문을 무시한다


    //      if (month < 6 || month > 8) // OR 1, 2, 3,4, 5, 9, 10, 11, 12
    //      {                          
    //         printf("일반 요금 적용 \n"); 
                                      
    //      }
    //     // 위 문장의 조건을 만족 하지 못했을 때 이 문장을 실행한다.
    //     // 위 문장의 조건을 만족했다고 해서 이 문장을 무시하는게 아니라
    //     // 이 문장의 조건을 만족하지 않았기 때문에 무시되는 것이다.
    //     // 문장을 만들 때 두 문장 다 되게 하면 안되고
    //     // 선택지가 있도록 만들어야한다
    //     // 만약 아래 문장에서 조건을 if (month < 8 || month > 8)
    //     // 으로 수정하고 7을 입력하면 "성수기 요금 적용" "알반 요금 적용"
    //     // 둘다 print 된다.
    // }

    //삼항연산자 (또는 조건 연산자)
    // expression1 ? expression2 : expression3
    // 만약 express1이 참이면 express2가 수행, 참이 아니면(거짓이면이 아님) express3이 수행됨

    // ex)
    // a = 1, b = 0
    // a || b ? 1 : 2
    // ||(or연산자) : 논리표에 의해 a || b(exp1) 가 참이므로 1(exp2)이 실행
    // a && b ? 1 : 2
    // &&(and연산자) : 논리표에 의해 a && b(exp1) 는 거짓이므로 2(exp3)가 실행됨
    // 잘 안쓰게 된다. 볼줄은 알아야한다. 대신 if문이 길어 질 수 도 있음
    /* ex
    int main()
    {
      if(..)
      {
        ...
      }
      else
      {
      ...
      참이면 if
      아니면 else
      삼항연자와 같은 논리
      }
    } 이 처럼 길어 진다
    */

    //특수연산자
    // sizeof() // 소괄호안에 것을 바이트크기로 변환
    // & // 변수가 저장된 메모리상의 주소값을 반환
         // 해당 변수가 메모리에서 어느 위치에 저장되어 있는지를 나타내는 고유한 식별 번호를 얻는다는 의미

    // * // 변수의 포인터 (혼자쓰이느냐 같이 쓰이냐에 따라 의미가 다름)

    // 비트 연산자(바이트는 a, b로 표현했고 비트는 0, 1만 들어갈 수 있다)
    // &, |, ^(XOR - 두개가 다르면 1을 반환), ~(not), <<, >>
    // 바이트 연산자와 차이점은 비트냐 바이트냐의 차이이다

    // 2진수를 16진수로 한번에 바꾸는법
    // 1110 1101 (msb lsb) 처럼 4개 씩 끊어준다.
    // {(8 * 1) + (4 * 1) + (2 * 1) + (1 * 0)}
    // + {(8 * 1) + (4 * 1) + (2 * 0) + (1 * 1)} = 14 + 13
    // 16진수로 변환하면 각각 E, D이다. 정답은 0xED
    // 0x가 붙으면 hexa(16진수) 값이다. 0x17이면 17은 십칠이 아니라 일 칠 이다.
    // 반대로 0x38을 2진수로 바꾸면?
    // 3 8을 역산으로 해보면 0011 1000 이된다. 

    // example 7-1)
    // #include <stdio.h> 

    // int main()
    // {
    //                              //  int는 4byte
    //      int n1 = 15;            // 0b00000000 00000000 00000000 00000000 00001111
    //      int n2 = 20;            // 0b00000000 00000000 00000000 00000000 00010100
    //      int result1 = n1 & n2;  // 0b00000000 00000000 00000000 00000000 00000100
    //      int result2 = n1 | n2;  // 0b00000000 00000000 00000000 00000000 00011111
    //      int result3 = n1 ^ n2;  // 0b00000000 00000000 00000000 00000000 00011011
    //      int result4 = ~n1;      // 0b11111111 11111111 11111111 11111111 11110000


    //      printf("n1 = %d \n", n1);
    //      printf("n2 = %d \n", n2);
    //      printf("result = %d \n", result1);
    //      printf("result = %d \n", result2);
    //      printf("result = %d \n", result3);
    //      printf("result = %d \n", result4);
    
    // }

  // ex 7-2)
  //   #include <stdio.h>

  //   int main()
  //  { 
  //       int n1 = 1;         // 0b00000000 00000000 00000000 00000000 00000001
  //       int s1 = n1 << 1;   // 0b00000000 00000000 00000000 00000000 00000010
  //       int s2 = n1 << 2;   // 0b00000000 00000000 00000000 00000000 00000100
  //       int s3 = n1 << 3;   // 0b00000000 00000000 00000000 00000000 00001000
  //       int s4 = n1 << 4;   // 0b00000000 00000000 00000000 00000000 00010000

  //       printf("n1 = %d \n", n1);
  //       printf("s1 = %d \n", s1);
  //       printf("s2 = %d \n", s2);
  //       printf("s3 = %d \n", s3);
  //       printf("s4 = %d \n", s4);


  //  }

// #include <stdio.h>

// int main()
// {
//     char a;

//     a = -128;
//     printf("%d \n", a);

//     a = -129;
//     printf("%d \n", a);
// } //언더 플로우

// #include <stdio.h>

// int main()
// {
//     unsigned char a;

//     a = 255;
//     printf("%d \n", a);

//     a = 256;
//     printf("%d \n", a); //오버플로우
// }

// #include <stdio.h>

// int main()
// {
//     unsigned char a;

//     a = 255;
//     printf("%d \n", a);

//     a += 1;
//     a = a + 1;
//     printf("%d \n", a); 
// }

// #include <stdio.h>
// // 비트 마스크 -> 특정 비트를 조작
// int main()
// {
//     unsigned short data = 0x5678; // 0101 0110 0111 1000

//     unsigned short msk1 = 0xf000; // 1111 0000 0000 0000
//     unsigned short msk2 = 0x0f00; // 0000 1111 0000 0000
//     unsigned short msk3 = 0x00f0; // 0000 0000 1111 0000
//     unsigned short msk4 = 0x000f; // 0000 0000 0000 1111

//     printf(" 결과값 1 = %#.4x \n", data & msk1); // 0x5000
//     printf(" 결과값 2 = %#.4x \n", data & msk2); // 0x0600
//     printf(" 결과값 3 = %#.4x \n", data & msk3); // 0x0070
//     printf(" 결과값 4 = %#.4x \n", data & msk4); // 0x0008
// } // &내가 원하는 위치에 있는 값을 뽑아옴

// #include <stdio.h>
// // 비트 마스크 -> 특정 비트를 조작
// int main()
// {
//     unsigned short data = 0x0000; // 0101 0000 0000 0000

//     unsigned short msk1 = 0x5000; // 1111 0000 0000 0000
//     unsigned short msk2 = 0x0f00; // 0000 1111 0000 0000
//     unsigned short msk3 = 0x00f0; // 0000 0000 1111 0000
//     unsigned short msk4 = 0x000f; // 0000 0000 0000 1111

//     printf(" 결과값 1 = %#.4x \n", data | msk1); // 0x5000
//     printf(" 결과값 2 = %#.4x \n", data | msk2); // 0x0600
//     printf(" 결과값 3 = %#.4x \n", data | msk3); // 0x0070
//     printf(" 결과값 4 = %#.4x \n", data | msk4); // 0x0008
// } //|연산은 내가 원하는 위치에 값을 넣을수있음 

// &연산자는 특정비트를 0으로 만들고
// |연산자는 특정비트를 1로 만든다
// ~연산자는 특정비트를 반전 시킨다
/*
0b10101 -> 0b11101 만들고 싶음
  10101
|     1 << 3 -> 01000

  10101
| 01000
----------
  11101 -> 3번째 자리에 1을 추가함

*** 삭제
  11101 -> 3번째 자리의 1을 삭제 하고 싶음 -> & 사용
  
  1<<3 -> 01000 -> ~(1<<3) == 10111

*/

// ex3)
// #include <stdio.h>

// int main()
// {
//     int a, b, c; //  정수타입의 a,b,c변수 선언
//     // int a;
//     // int b;
//     // int c; // 위와 같은 것임

//     double average; // 실수타입의 average변수 선언

//     printf("정수 3개를 입력하시오 : \n");
//     scanf("%d %d %d", &a, &b, &c); // 정수 3개를 입력받음
    

//     average = (double)(a + b + c) / 3; // 평균을 구함
//     printf("평균은 : %f \n", average); // 평균을 출력함, f는 실수형을 의미함, d는 정수형
// }

// ex4-1)
// #include <stdio.h>

// int main()
// {
//     int num = 0;

//     printf("숫자를 입력하세요 \n");
//     scanf("%d", &num); //정수를 받아서 num이라는 변수에 저장

//     if (num < 5)
//     {
//         printf("입력한 숫자는 5보다 작다\n");
//     }
//      if (num == 5)
//     {
//         printf("입력한 숫자는 5와 같다\n");
//     }
//      if (num > 5)
//     {
//         printf("입력한 숫자는 5보다 크다\n");
//     }
//     else
//     {
//         if(num == 5)
//         {
//             printf("입력한 숫자는 5와 같다\n");
//         }
//         else
//         {
//             printf("입력한 숫자는 5보다 크다\n");
//         }
//     }
// }

// ex4-2)
// #include <stdio.h>

// int main()
// {
//     int num = 0;

//     printf("숫자를 입력하세요 \n");
//     scanf("%d", &num); //정수를 받아서 num이라는 변수에 저장

//     if (num < 5)
//     {
//         printf("입력한 숫자는 5보다 작다\n");
//     }
//     else if (num == 5)
//     {
//         printf("입력한 숫자는 5와 같다\n");
//     }
//     else
//     {
//         printf("입력한 숫자는 5보다 크다\n");
//     }
// }

// ex5)
// #include <stdio.h>
// // switch case문
// int main()
// {
//     int num;
//     printf("미세먼지 농도를 선택하시오\n");
//     printf("1. 좋음\n");
//     printf("2. 보통\n");
//     printf("3. 나쁨\n");
//     scanf("%d", &num);

//     switch (num)
//     {
//         case 1:
//             printf("미세먼지 농도가 좋으니까 마스크 안써도됨\n");
//             break;
        
//         case 2:
//             printf("미세먼지 농도가 보통이니까 마스크 대충 쓰세요\n");
//             break;

//         case 3:
//             printf("미세먼지 농도가 나쁘니까 방독면 착용하세요\n");
//             break;
//         default:
//             printf("잘못 눌렀습니다\n");
//             break;
//     }
 
// }


// ex6)
// #include <stdio.h>
// //while문 (조건반복문)
// int main()
// {
//     int weight = 80;
//     int count = 0;
    
//     while (weight > 60) //while(1) 무한루프
//     {
//         printf("매일 빡시게 운동해서 1kg 감량하기\n");
//         weight--; // 60이 될때까지 반복
//         count++;
//     }
//     printf("축하합니다. 운동 안해도 됨\n");
//     printf("%d 일 운동 했음 \n\n", count);
// }


// ex7-1)
// #include <stdio.h>
// // for 문 (반복문) //for(;;) 무한반복문
// int main()
// {
//     int weight;
//     int count = 0;
    
//     // for(초기식(값) ; 조건식(비교) ; 증감식(변화))
//     for(weight = 80; weight > 70; weight--) // weight = 80부터 시작해서 70보다 클때까지 반복
//     {
//         printf("빡시게 운동 했음\n");
//         count++;
//     }
//     printf("축하합니다. 운동 안해도 됨\n %d일 운동 했음 \n", count);

//     //for(int i = 0; i < 200; i++) //200번 반복
//     //for(int i = 10; i > 0; i--) // 10부터 0까지 반복
//     for(int i = 0; i < 5; i++)
//     {
//         for(int j = 0; j < 5; j++)
//         {
//             printf("%d ", i);
//         }
//     }
//     {
//         printf("%d ", i);
//     }
//     {
//         printf("%d ", i);
//     }
//     {
//         printf("%d ", i);
//     }
//     {
//         printf("%d ", i);
//     }
// }

// ex7-2)
// #include <stdio.h>

// int main()
// {
//     int i, j;

//     for(i = 0; i < 3; i++)
//     {
//         printf("외부for문 시작 %d\n", i);
//         for(j = 0; j < 3; j++)
//         {
//             printf("내부for문 시작 %d\n", j);
//         }
//         printf("내부for문 끝 %d\n", i);
        
//     }
// }


// ex 7-3)
// #include <stdio.h>

// int main()
// {
//     int i, j;

//     for(i = 0; i < 5; i++)
//     {
//         for(j = 0; j <= i; j++)
//         {
//             printf("*");
//         }
//         printf("\n");
        
//     }
// }

// ex7-4)
// #include <stdio.h>

// int main()
// {
//     int i, j;

//     for(i = 0; i < 4; i++)
//     {
//         for(j = 4; j > i; j--)
//         {
//             printf("*");
//         }
//         printf("\n");
        
//     }
// }

// ex 7-5)
// #include <stdio.h>
// // 별찍기 위아래 통합
// int main()
// {
//     int i, j;

//     for(i = 0; i < 5; i++)
//     {
//         for(j = 0; j <= i; j++)
//         {
//             printf("*");
//         }
//         printf("\n");
        
//     }
//     for(i = 4; i >0; i--)
//     {
//         for(j = 0; j < i; j++)
//         {
//             printf("*");
//         }
//         printf("\n");
//     }
// }

/*
* 함수 (Function)
- 프로그래밍에서 함수란 특별한 목적의 작업을 수행하기 위한 독립적으로 설계된
  프로그램 코드의 집합 !!
- 표준함수, 사용자 정의 함수

type function_name(parameter list, , , ...)
{
    declarations
    statement
}

int sum(x, y)
{
    int sum; //선언

    sum = x + y; // 함수의 본체

    return sum;
}

void sum(x, y)
{
    int sum;
    sum = x + y;
}
*/

// ex8-1))
// #include <stdio.h>

// int printHello() ;


// int main()
// {
//     printf("함수를 호출 합니다\n");
//     printHello(); 

//     printf("함수를 한번 더 호출 합니다\n");
//     printHello(); 
// }

// int printHello() // 함수의 원형
// {
//     printf("Hello World\n");
//     return 0;
// }

// ex 8-2)
// #include <stdio.h>

// int add(int a, int b); // 함수의 원형

// int main()
// {
//     int x, y, z;
//     printf("정수 2개를 입력하시오 : \n");
//     scanf("%d %d", &x, &y); // 정수 2개를 입력받음
    
//     z = add(x, y);
//     printf("%d\n", z);
// }

// int add(int a, int b) // 함수의 원형
// {
//     int sum;
//     sum = a + b; // 함수의 본체
//     printf("두 수의 합은 : %d \n", sum);
//     return 0;
// }

/*
* 변수의 유효범위
- 지역변수
- 전역변수
- 정적변수
*/

// 지역변수
/*
- 블록 {} 내에서 선언된 변수
- 블록 내에서만 유효, 블록이 종료되면 메모리에서 사라짐
- 메모리 영역내의 stack(스택)영역에 저장, 초기화하지 않으면 쓰레기값
- 함수의 매개변수도 함수내에서는 지역변수로 취급
- 프로그램이 실행될 때 메모리 확보
*/

// ex 9-1)
// #include <stdio.h> 
// void local(void);
// int main()
// {
//     int i = 5;       // local variable
//     int var = 10;    // local variable

//     printf("main() 함수내의 지역변수 var의 값 : %d \n", var);

//     if(i < 10)
//     {
//         local();        // 함수 호출
//         int var = 30;   // if문내의 local variable
//         printf("if문내의 지역변수 var의 값 : %d \n", var);
//     }
//     printf("현재 지역변수 var의 값 : %d \n", var);
// }

// void local(void)
// {
//     int var = 20;      // local()내의 local variable
//     printf("local() 함수내의 지역변수 var의 값 : %d \n", var);
// }


/*
* 정적변수
- static 키워드로 선언된 변수 ex) static int a;
- 전역변수와 지역변수의 특징을 모두 가지고 있다
- 함수내에서 선언된 정적변수는 단 한번만 초기화 가능
  프로그램이 종료될때까지 메모리에 남아있음(프로그램이 종료되어야 메모리에서 삭제됨)
  위에서 처럼 선언된 정적변수는 지역변수처럼 해당 함수(블록)에서만 접근 가능
- 전역변수처럼 초기화하지 않으면 0으로 초기화됨
*/

// #include <stdio.h>

// void local();
// void staticVar();

// int main()
// {
//     int i; 
//     for(i = 0; i < 3; i++)
//     {
//         local();
//         staticVar();
//     }
// }

// void local()
// {
//     int count = 1;
//     printf("local() 함수가 %d 번째 호출되었다 \n", count);
//     count++;
// }

// void staticVar()
// {
//     static int staticCount = 1;
//     printf("staticVar() 함수가 %d 번째 호출되었다 \n", staticCount);
//     staticCount++;
// }

/*
* 전역변수
- 전역변수란 ??? >>> 함수의 외부에 선언된 변수(main)
- 프로그램의 어디에서나 접근이 가능, 프로그램이 종료되어야 메모리에서 삭제
- data 영역에 저장, 컴파일 할 때 메모리 확보
- 초기화하지 않아도 자동으로 0으로 초기화
*/


// ex 9-3)
// #include <stdio.h>

// void local();     // 함수의 원형 선언
// int var;         // var이라는 전역변수 선언

// int main()
// {
//     printf("전역변수 var값 : %d \n", var);
//     var++;
//     int var = 10; // 지역변수 var 선언
//     printf("main() 함수내에서의 지역변수 var 값 : %d \n", var);

//     if(1)
//     {
//         local();
//         printf("현재 변수 var의 값 : %d \n", var);
//     }
//     printf("더 이상 main() 함수에서는 전역변수 var에 접근 불가 !!!\n");
  
// }

// void local()
// { 
//     int var = 20;
//     printf("local() 함수내에서 접근한 지역변수 var의 값은? : %d \n", var);
// }

/*
* 배열 !!
- 같은 데이터타입(형)의 변수들로 이루어진 유한집합 !!
- 배열을 구성하는 각각의 값 -> 배열요소 (element)
- 요소의 위치를 가리키는 것 -> 인덱스(index)
- 인덱스의 값은 언제나 0 부터 시작, 또한 양의 정수 값만 가질 수 있다.
- 배열의 모든 요소는 항상 연속된 메모리에 저장됨 !!!!!

==>>int num[0]; ----------> 불가 !! 반드시 공간이 확보되어야함
==>>int size = 100;
    int data[size]; ----------> 불가 !!!
==>>#define MAX 5
    int data [MAX]; ----------> 가능 (매크로 상수로)
*/

//배열의 크기
// #include <stdio.h>

// int main()
// {
//     int arr[5] = {0,};         // 4바이트인 int타입의 배열 5칸을 선언
//     int byteArr = 0;    // 배열의 바이트 크기를 저장할 변수 선언
//     int size = 0 ;      // 배열의 크기를 저장할 변수 선언

//     byteArr = (sizeof(arr));
//     printf("배열의 바이트 크기 : %d \n", byteArr);

//     size = sizeof(arr) / sizeof(arr[0]);
//     printf("배열의 크기 : %d \n", size);

//     arr[2] = 7;

//     // for(int i = 0; i < size; i++)
//     // {
//     //     arr[i] = 0; // 배열의 모든 요소를 0으로 초기화
//     // }
//     for(int i = 0; i < size; i++) //지역 변수이기 때문에 i 써도 상관없다
//     {
//         printf("arr[%d] : %d :\n", i, arr[i]);
//     }
// }

// 5월 26일
// #include <stdio.h>
// #define ARR_SIZE 5   // 매크로 상수로 지정

// int add(int a, int b)
// {
//     return a + b; // {return a + b;}와 동일 // 주석부분 윗줄에 써도됨, 세미콜론 반드시 붙일것
// }

// int main()
// {
//     int arr[ARR_SIZE] = {0}; // 배열 전체를 0으로 초기화

//     arr[0] = 5;
//     arr[1] = arr[0] + 10; // 배열의 요소(원소)를 수식에 이용 // arr[0] + 10 = 5 + 10 = 15
//     arr[2] = add(arr[0], arr[1]); // add(5, 15) = 20 // 함수의 인자로 사용

//     printf("정수 2개를 입력 하시오 : ");
//     scanf("%d %d", &arr[3], &arr[4]); // 입력값을 배열의 요소로 저장

//     for(int i = 0; i < ARR_SIZE; i++)
//     {
//         printf(" %d  ", arr[i]); // 배열의 요소를 출력
//     }
//     printf("\n\n");
//     printf("arr[5] = %d \n", arr[5]); // 배열의 크기를 벗어난 접근, 쓰레기값이 출력됨
// }

// #include <stdio.h>

// int main()
// {
//     int i = 5;
//     char c = 'A';

//     printf(" 변수 i의 주소값 : %p\t 변수 i의 값 : %d \n", &i, i);
//     printf(" 변수 c의 주소값 : %p\t 변수 i의 값 : %d \n", &c, c);
// }

// #include <stdio.h>

// int main()

// {
//     int arr[] = {1, 3, 5, 7, 9};
//     // arr[0] = 1;
//     // arr[1] = 3;
//     // arr[2] = 5;
//     // arr[3] = 7;
//     printf(" arr 배열의 첫번째 주소값 : %p \t 요소값 : %d\n", &arr[0], arr[0]);
//     printf(" arr 배열의 두번째 주소값 : %p \t 요소값 : %d\n", &arr[1], arr[1]);
//     printf(" arr 배열의 세번째 주소값 : %p \t 요소값 : %d\n", &arr[2], arr[2]);
//     printf(" arr 배열의 네번째 주소값 : %p \t 요소값 : %d\n", &arr[3], arr[3]);
// }

// #include <stdio.h>

// int main()
// {
//     // 2차원 배열
//     int arr_2[3][3] = //[행][열]
//     {{1,2,3}, {4,5,6}, {7,8,9}};

//     // printf(" 1행 1열 : %d | ", arr_2[0][0]);
//     // printf(" 1행 2열 : %d | ", arr_2[0][1]);
//     // printf(" 1행 3열 : %d \n", arr_2[0][2]);
//     // printf(" 2행 1열 : %d | ", arr_2[1][0]);
//     // printf(" 2행 2열 : %d | ", arr_2[1][1]);
//     // printf(" 2행 3열 : %d \n", arr_2[1][2]);
//     // printf(" 3행 1열 : %d | ", arr_2[2][0]);
//     // printf(" 3행 2열 : %d | ", arr_2[2][1]);
//     // printf(" 3행 3열 : %d \n", arr_2[2][2]);
//     // {
//     //     {1,2,3},
//     //     {4,5,6},
//     //     {7,8,9}
//     // };
//     //int arr_2[3][3] = {1,2,3,4,5,6,7,8,9}; // 2차원 배열 초기화
//     for(int i = 0; i < 3; i++)
//     {
//         for(int j = 0; j < 3; j++)
//         {
//             printf(" %d행 %d열 : %d",i+1, j+1, arr_2[i][j]);
//             if(j<2) printf(" | ");
//             if(j == 2) printf("\n");
//         }
//         //printf("\n");
//     }
// }

// #include <stdio.h>

// int main()
// {
//     // 2차원 배열
//     int arr_2[3][3] = {{1,2,3}, {4,5,6}, {7,8,9}}; //행은 생략되도 열은 생략이 안된다

//     for(int i = 0; i < 3; i++)
//     {
//     for(int j = 0; j < 3; j++)
//        {
//         printf("%d 행 %d열 : %d | 주소 : %p \n", i+1, j+1, arr_2[i][j], &arr_2[i][j]);
//        }
//     }
// }

// 포인터 : 메모리상에 위치한 특정 데이터의 시작주소를 보관하는 변수 (중요!)
// 포인터 연산자
// 주소연산자 (&) : 변수의 이름앞에 사용, 변수의 주소를 반환(번지연산자)
// 참조연산자 (*) : 포인터의 이름앞에 사용, 포인터가 가리키는 곳(주소)에 저장된 값을 반환
// 포인터 선언
// 데이터형 *변수명(데이터형* 변수명;, *위치는 상관없음); <<< 포인터 변수 선언
// ex) int *ptr; // int형 포인터 변수 ptr 선언
// 포인터의 크기는 일정 !!
// 포인터의 크기는 플랫폼에 따라서 결정된다
// 32bit : 4byte, 64bit : 8byte 포인터는 주소값을 저장하는 변수이기 때문에 주소값을 저장할 수 있는 크기를 가져야 한다

// #include <stdio.h>

// int main()
// {
//     int *pi;          //int형 포인터 변수 pi 선언
//     double *pd;       //double형 포인터 변수 pd 선언
//     char *pc;         //char형 포인터 변수 pc 선언

//     printf("int형 포인터 변수 pi의 크기 : %d \n", sizeof(int*));
//     printf("double형 포인터 변수 pd의 크기 : %d \n", sizeof(double*));
//     printf("char형 포인터 변수 pc의 크기 : %d \n", sizeof(char*));
// }

// 포인터의 초기화
// 절대 절대 절대 never 포인터에 주소를 직접 대입해서는 안됨 !!!
// /*int *ptr;
// ptr = 0x123456;*/ 잘못된예시
// ===========================
// int *ptr = 0;
// ptr = NULL; // NULL은 0과 동일한 의미로 사용됨, 이 유형으로 초기화 할것을 권장

// /*
// * & 연산자 -> 주소를 반환
// */

// #include <stdio.h>

// int main()
// {
//     int a;
//     a = 20;
//     printf("%p \n", &a); // a의 주소값을 출력
// }

/*
* 포인터의 시작
*/
// #include <stdio.h>

// int main()
// {
//     int *ptr;
//     int a;

//     ptr = &a;
//     printf("포인터 변수 ptr에 들어있는 것(값) : %p \n", ptr);
//     printf("포인터 변수 ptr에 들어있는 것(값) : %p \n", &ptr); 
//     printf("int a변수의 메모리 주소값 : %p \n", &a);
// }

/*
*   * 연산자 (역참조연산자)
*     포인터가 가리키는 주소에 저장된 값을 반환
*/

// #include <stdio.h>

// int main()
// {
//     int *ptr;
//     int a = 2;

//     ptr = &a;

//     printf("a의 값 : %d \n", a);
//     printf("a의 주소값 : %p \n", &a);

//     printf("*ptr의 값 : %d \n", *ptr); // ptr이 가리키는 주소에 저장된 값
//     printf("ptr의 가리키는 곳 : %p\n\n", ptr);
// }

// 포인터도 변수다 !!!

// #include <stdio.h>

// int main()
// {
//     int a, b;     // 정수형 변수(일반 변수) a, b 선언
//     int *ptr;     // 여기에서 int 의미는  :  포인터가 가리키는 곳의 데이터 타입

//     ptr = &a;     // 포인터 변수 ptr에 a의 주소값을 저장
//     *ptr = 2;     // 포인터 ptr이 가리키는 곳에 2를 저장 (a에 2을 저장)
//     ptr = &b;     // 포인터 ptr이 b의 주소값으로 변경 저장 (변수이니까)
//     *ptr = 3;     // 포인터 ptr이 가리키는 곳에 3을 저장 (b에 3을 저장)

//     printf("a의 값 : %d \n", a);
//     printf("b의 값 : %d \n\n\n", b);
// }

// #include <stdio.h>

// int main()
// {
//     int a, b;
//     const int *ptr = &a;

//     ptr = &a; // 오류 없음, const로 선언된 포인터는 가리키는 곳의 주소를 변경할 수 있음
//     *ptr = 3; // 오류 발생, const로 선언된 포인터는 가리키는 곳의 값을 변경할 수 없음
//     ptr = &b; // 오류 없음, 포인터 자체는 변경 가능
// }

// #include <stdio.h>

// int main()
// {
//     int a, b;
//     int *const ptr = &a; // const로 한거는 반드시 선언과 동시에 초기화 해야함 !!

//     ptr = &a; // 오류 발생, const로 선언된 포인터는 가리키는 곳의 주소를 변경할 수 없음
//     *ptr = 3; // 오류 없음, const로 선언된 포인터는 가리키는 곳의 값을 변경할 수 있음
//     ptr = &b; // 오류 발생, 포인터 자체는 변경할 수 없음
// }


// 포인터의 덧셈 (주소값이 증가)
#include <stdio.h>

// int main()
// {
//     // int a;
//     // char b;
//     // double c;

//     // int *pa = &a;
//     // char *pb = &b;
//     // double *pc = &c;

//     // printf("pa의 주소값 : %p \n", pa);
//     // printf("(pa+1)의 주소값 : %p \n", (pa + 1)); // 4바이트 증가
//     // printf("pb의 주소값 : %p \n", pb);
//     // printf("(pb+1)의 주소값 : %p \n", (pb + 1));
//     // printf("pc의 주소값 : %p \n", pc);
//     // printf("(pc+1)의 주소값 : %p \n", (pc + 1));

//     int a;
//     int *pa = &a;
//     int b;
//     int *pb = &b;
//     int *pc = pa + pb; // 포인터끼리의 덧셈은 불가능, 주소값을 더할 수 없음
// }

// 포인터의 대입
// #include <stdio.h>

// int main()
// {
//     int a;
//     int *pa = &a; // a의 주소값을 pa에 저장
//     int *pb;

//     *pa = 3 ; // a에 3을 저장
//     pb = pa; // pa의 주소값을 pb에 저장, 이제 pb도 a의 주소를 가리킴, 둘 다 주소이기 때문에 성립

//     printf(" pa 가 가리키는 것 : %d\n", *pa); // a의 값 출력
//     printf(" pb 가 가리키는 것 : %d\n", *pb); // a의 값 출력

// }

// 배열과 포인터의 관계
// #include <stdio.h>

// int main()
// {
//     int arr[10] = {1,2,3,4,5,6,7,8,9,10}; // 정수형 배열 선언과 동시에 초기화

//     for(int i = 0; i < 10; i++)
//     {
//         printf("arr[%d]의 주소값 : %p \n", i, &arr[i]); // 배열의 요소 출력
//     }
// }

// 포인터로써 배열에 접근
// #include <stdio.h>

// int main()
// {
//     int arr[10] = {1,2,3,4,5,6,7,8,9,10}; // 정수형 배열 선언과 동시에 초기화
//     int *parr;
//     parr = &arr[0]; // 배열의 첫번째 요소의 주소값을 parr에 저장

//     for(int i = 0; i < 10; i++)
//     {
//         printf("arr[%d]의 주소값 : %p \n", i, &arr[i]); // 배열의 요소 출력
//         printf("*(parr+%d)의 값 : %p \n", i, (parr + i)); // 배열의 요소 출력

//         if(&arr[i] == (parr + i)) // 배열의 요소의 주소값과 parr+i의 주소값이 같은지 비교 
//                                   // 만일 (parr+i)가 성공적으로 arr[i]를 가리킨다면
//         {
//             printf("arr[%d]의 주소값과 parr+%d의 주소값은 같습니다. 일치 합니다.\n", i, i);
//         }
//         else
//         {
//             printf("arr[%d]의 주소값과 parr+%d의 주소값은 다릅니다. 불일치 합니다.\n", i, i);
//         }
//     }
// }

// *연산자로 접근
// #include <stdio.h>

// int main()
// {
//     int arr[10] = {1,2,3,4,5,6,7,8,9,10}; // 정수형 배열 선언과 동시에 초기화
//     int *parr;
//     parr = &arr[0]; // 배열의 첫번째 요소의 주소값을 parr에 저장
//     printf(" arr[3] = %d *(parr + 3) = %d \n", arr[3], *(parr + 3)); // arr[3]와 *(parr + 3)의 값 비교
// }

// 배열의 이름과 포인터와의 관계
// arr[0] 과 주소값의 관계

// #include <stdio.h>

// int main()
// {
//     int arr[3] = {1,2,3}; // 정수형 배열 선언과 동시에 초기화
//     // printf("arr의 정체 : %p \n",arr); // 배열의 이름은 배열의 첫번째 요소의 주소값을 의미
//     // printf("arr[0]의 주소값 : %p \n", &arr[0]); // 배열의 첫번째 요소의 주소값

//     // 배열의 이름 arr과 arr[0]의 주소값이 동일
//     // 배열의 이름이 첫번째 원소를 가리키는데... 포인터는 아니다 !!
//     // 배열은 배열이고...포인터는 포인터다 !!

//     // int *parr = arr;

//     // printf("sizeof(arr) : %d \n", sizeof(arr)); // 배열의 크기
//     // printf("sizeof(parr) : %d \n", sizeof(parr)); // 포인터의 크기

//     // C언어에서 배열의 이름이 sizeof, &(주소값)연산자 등과 같이 사용할 때를 제외하면
//     // 배열의 이름이 암묵적으로 첫번째 원소를 가리키는 포인터 타입으로 변환된다

//     int *parr; // 포인터 변수 parr 선언
//     parr = arr; // parr = &arr[0]; // 배열의 이름 arr은 첫번째 원소의 주소값을 의미, parr은 포인터 변수
//     // arr[i] --> (arr+i) <<<< 컴파일러가 이렇게 해석합니다
//     printf("arr[1] : %d \n", arr[1]); // 배열의 두번째 요소의 값
//     printf("parr[1] : %d \n", parr[1]); // 포인터를 이용한 배열의 두번째 요소의 값


// }


// #include <stdio.h>

// int main()
// {
//     int arr[10] = {100,99,87,67,78,78,56,56,79,90};
//     int *parr = arr; // 포인터변수 선언과 동시에 배열을 가리킴 (0번 인덱스)
//     int sum;

//     while(parr - arr <= 9)
//     {
//         sum += *parr; // 포인터를 이용한 배열의 요소의 값 //sum = sum + (*parr);
//         parr++; // 다음 요소로 이동
//         // arr++; 이거 안됨!! 포인터 아님.. 포인터처럼 행동함 !!
//     }
//     printf("평균은? : %d \n", sum / 10); // 평균값 출력
// }

// 포인터의 포인터 (이중포인터)
// #include <stdio.h>

// int main()
// {
//     int a;
//     int *pa;
//     int **ppa;

//     pa = &a;
//     ppa = &pa;

//     a = 3;

//     printf("a의 값 : %d || *pa : %d || **ppa : %d \n", a, *pa, **ppa);
//     printf("a의 주소 : %p || pa가리키는 주소 : %p || *ppa의 저장 값 : %p\n", &a, pa, *ppa);
//     printf("pa의 주소 : %p || ppa가리키는 주소 : %p \n", &pa, ppa); 

// }

// #include <stdio.h>

// int main()
// {
//     int arr[2][3];
//     printf("arr[0] : %p \n", arr[0]);
//     printf("&arr[0][0] : %p \n", &arr[0][0]);

//     printf("arr[1] : %p \n", arr[1]);
//     printf("&arr[1][0] : %p \n", &arr[1][0]);
// }

// 구조체
// 정의 : 서로 다른 데이터형의 변수들을 묶어서 사용 -> 사용자 정의 데이터형을 생성

// #include <stdio.h>

// struct human    // human 이라는 구조체 정의
// {
//     int age;    // 나이 -> 멤버변수
//     int height; // 키 -> 멤버변수
//     int weight; // 몸무게 -> 멤버변수
// };              // 마지막에 세미콜론

// int main()
// {
//     struct human info;      // stuct human 이라는 데이터형, info라는 변수명
    
//     // 변수를 초기화
//     info.age = 99;
//     info.height = 180;
//     info.weight = 100;

//     printf("info의 멤버변수 키는? : %d \n", info.height); //height가 아닌 info.height
// }

// #include <stdio.h>  // 표준함수에서 입출력과 관련                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
// #include <string.h> // 표준함수에서 문자열과 관련

// struct contact
// {
//   char name[20];
//   char phone[20];
//   int ringtone;
// };


// int main()
// {
//     struct contact ct = {"이홍재", "01011112222", 0};
//     struct contact ct1 = {0};
//     struct contact ct2 = ct;

//     ct.ringtone = 5;
//     strcpy(ct.phone,"01033334444");
//     printf("이 름 : %s \n", ct.name);
//     printf("전 번 : %s \n", ct.phone);
//     printf("벨소리 : %d \n", ct.ringtone);

//     printf("이 름 : %s \n", ct1.name);
//     printf("전 번 : %s \n", ct1.phone);
//     printf("벨소리 : %d \n", ct1.ringtone);

//     printf("이 름 : %s \n", ct2.name);
//     printf("전 번 : %s \n", ct2.phone);
//     printf("벨소리 : %d \n", ct2.ringtone);
// }

/*
* c언어에는 문자열이 없다
* 문자열은 "very" (연속된 문자들의 집합)
* 문자 'a' (하나의 문자로 구성)
* 문자열의 표현방법 -> 배열에 저장 (char)
* --> 배열의 마지막 인덱스에 널문자가 있어야 함!!
* very\0 -> very 자체는 4문자 이지만 문자열로 저장시 널문자 추가해서 5칸의 크기가 필요함!!!!
*/

// #include <stdio.h>

// typedef unsigned int myunsignedInteger;     // 자료형 재정의 !!

// int main()
// {
//     //unsigned int a;
//     myunsignedInteger a;

//     a = 10;

//     printf(" a : %d \n", a);
// }

// #include <stdio.h>

// typedef struct food
// {
//     char name[10];
//     int price;
//     int cookTime;
//     int preperence;
// }FOOD;      // int, double, 

// int main()
// {
//     FOOD good = {"test", 30, 50, 100};
//     printf("name : %s\n", good.name);
// }

// #include <stdio.h>

// typedef struct test
// {
//   int a;        // 
//   int b;        // 0x1238(예시 주소)
// }TEST;

// int main()
// {
//     TEST st = {0};  //st의 첫번째 메모리 주소 (예시 : 0x1234, 0x1238)
//     TEST *ptr;    // struct test 타입의 구조체를 가리키는 포인터 변수 (구조체가 아님 !!)

//     ptr = &st; // ptr의 st의 주소 0x1234

//     (*ptr).a = 1;     // 아래처럼 멤버변수의 값을 제어 (->) 를 사용
//     ptr->b = 2;
// }

