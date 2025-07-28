// C언어 시작
// 5월 ??일 ??요일
// 강의 : 


// // Exapmle 1)
// #include <stdio.h>  // IO관련 헤더파일 불러옴. 전처리기
// #define APPLE 10    // 앞으로 APPLE이라는 이름을 10으로 사용하겠다.
// #define NAME "사과"  // 문자열을 정의할때는 ""로 감싸야함

// // 한줄 주석 (설명)
// /* 여러줄 주석
// * 여기부터 주석 시작
// * 여기도 주석
// * 여기까지 주석
// */

// // C언어 시작인 메인함수 시작
// int main()
// {
//     char ch;    // 문자형 변수 선언
//     int num;    // 정수형 변수 선언
//     double x;   // 실수형 변수 선언

//     int a = 20;
//     int b = 0xff;

//     // 터미널에 hello world를 프린트
//     printf("hello world\n\n\n");
//     printf("%s, %d, %c, %d%%, %x, %d \n\n\n", NAME, APPLE, 'a', a, b, b);

//     // 문자열은 "" 사용 VS char형은 '' 사용
//     // %s : 문자열, %d : 정수형, %c : 문자형, %x : 16진수, %% : %
//     // %f : 실수형, %o : 8진수
//     // %p : 포인터형, %u : unsigned int
//     // \n 줄바꿈
//     // \r 커서를 맨 앞으로
//     // \t 탭 (4칸 띄우기)
// }


// // Example 2)
// #include <stdio.h>

// // sizeof() 연산자 - 괄호안에 있는것을 바이크 크기로 반환 (비트가 아님!)
// int main()
// {
//     char ch;
//     int num;
//     double x;
//      // 여기서는 값을 사용하는게 아니라 측정만 하기 때문에 
//      // 초기화 하지 않아도 쓰레기값 문제가 발생하지 않는다

//     printf("char 형의 바이트 크기 : % d \n", sizeof(char));
//     printf("short 형의 크기 : % d \n", sizeof(short));
//     printf("long 형의 바이트 크기 : % d \n", sizeof(long));
//     printf("float 형의 바이트 크기 : % d \n", sizeof(float));

//     printf("ch 형의 바이트 크기 : % d \n", sizeof(ch));
//     printf("num 형의 바이트 크기 : %d \n", sizeof(num));
//     printf("x 형의 바이트 크기 : % d \n", sizeof(x));
// }