//
//  main.cpp
//  homework
//
//  Created by Mac on 2017/5/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

#include<iostream>
#include <string>
#include <algorithm>
#include <list>
#include <fstream>
using namespace std;

class Car{
private:
    int num;
    string time;
    int seat;
    int sellNum;
    string distination;
    double price;
public:
    Car(int n, string t, int se, int sel, string dis, double p);
    void Change(string t, int s);
    void Sell();
    void Return();
    void Show() const;
    int Rnum() {return num;}
    int Rsellnum() {return sellNum;}
    string Rdis() {return distination;}
};

Car::Car(int n, string t, int se, int sel, string dis, double p)
{
    num = n;
    time = t;
    seat = se;
    sellNum = sel;
    distination = dis;
    price = p;
}

void Car::Change(string t, int s)
{
    time = t;
    seat = s;
}

void Car::Sell()
{
    sellNum++;
}

void Car::Return()
{
    sellNum--;
}

void Car::Show() const
{
    cout << "发车时间:" << time << endl;
    cout << "班次号:" << num << endl;
    cout << "票价:" << price << endl;
    cout << "已售车票数:" << sellNum << endl;
    cout << "到达地点:" << distination << endl;
    cout << "座位数:" << seat << endl;
}



void Menu();
void Display(int ch);
void Add();
void Search();
void Change();
void Delete();
void SellTicket();
void ReturnTicket();
template<class T>
void fncin(T & temp);

//创建一个列表存放列车信息
list<Car> Cars;
ofstream fout("Users/mac/Desktop/ios-test/outfile.txt");



int main()
{
    int choice;
    Menu();
    cin >> choice;
    while(choice < 1 || choice > 6)
    {
        Menu();
        cin >> choice;
    }
    while(choice != 7)
    {
        Display(choice);
        Menu();
        cin >> choice;
    }
    return 0;
}

void Menu()
{
    cout << "输入1~7进行选择:\n";
    cout << "1. 班次添加\n";
    cout << "2. 班次查询\n";
    cout << "3. 班次信息修改\n";
    cout << "4. 删除班次\n";
    cout << "5. 售票（发车10分钟前）\n";
    cout << "6. 退票（发车10分钟前）\n";
    cout << "7. 退出\n";
}

void Display(int ch)
{
    switch(ch)
    {
        case 1: Add();break;
        case 2: Search();break;
        case 3: Change();break;
        case 4: Delete();break;
        case 5: SellTicket();break;
        case 6: ReturnTicket();break;
        case 7: break;
        default: break;
    }
}

void Add()
{
    list<Car>::iterator it;
    int num;
    string time;
    int seat;
    int sellNum;
    string distination;
    double price;
    
    cout << "输入班次号:";
    fncin(num);
    cout << "输入发车时间(如**:**):";
    fncin(time);
    cout << "输入座位数:";
    fncin(seat);
    cout << "已售车票数:";
    fncin(sellNum);
    cout << "输入到达地点:";
    fncin(distination);
    cout << "输入票价:";
    fncin(price);
    Car temp(num,time,seat,sellNum,distination,price);
    Cars.push_back(temp);
}

void Search()
{
    int n;
    cout << "输入你想查询的班次号:";
    cin >> n;
    //创建一个迭代器
    list<Car>::iterator it;
    for(it = Cars.begin(); it != Cars.end(); it++)
    {
        if((*it).Rnum() == n)
            (*it).Show();
    }
}

void Change()
{
    int n;
    string ti;
    int se;
    cout << "输入你想修改的班次号:";
    cin >> n;
    list<Car>::iterator it;
    for(it = Cars.begin(); it != Cars.end(); it++)
    {
        if((*it).Rnum() == n)
        {
            cout << "输入新的发车时间:\n";
            cin >> ti;
            cout << "输入新的座位数:\n";
            cin >> se;
            (*it).Change(ti, se);
        }
    }
}

void Delete()
{
    int n;
    cout << "输入你想删除的班次号:";
    cin >> n;
    list<Car>::iterator it;
    for(it = Cars.begin(); it != Cars.end(); it++)
    {
        if((*it).Rnum() == n){
            Cars.erase(it);
            break;
        }
    }
}

void SellTicket()
{
    string dis;
    cout << "输入你想到达的地点:";
    cin >> dis;
    list<Car>::iterator it;
    for(it = Cars.begin(); it != Cars.end(); it++)
    {
        if((*it).Rdis() == dis)
            (*it).Sell();
    }
}

void ReturnTicket()
{
    int n;
    cout << "输入你想退票的班次号:";
    cin >> n;
    list<Car>::iterator it;
    for(it = Cars.begin(); it != Cars.end(); it++)
    {
        if((*it).Rnum() == n)
            (*it).Return();
    }
}
//模版
template<class T>
void fncin(T & temp)
{
    cin >> temp;
    fout << temp << endl;
}
