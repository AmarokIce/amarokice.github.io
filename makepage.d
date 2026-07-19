import std.stdio : writef, readln;
import std.datetime.systime : Clock;
import std.string : split, empty, format, replace;
import std.file : write;

string base = "---
layout: post
type: blog
title: %s
date: %s
author: Amaruq·Illaujaq
categories: [%s]
tags: [%s]
pin: %s
---
";

void setLanguageCP() {
  version (Windows) {
    import core.sys.windows.windows : SetConsoleCP, SetConsoleOutputCP, CP_UTF8;

    SetConsoleCP(CP_UTF8);
    SetConsoleOutputCP(CP_UTF8);
  }
}

void main() {
  setLanguageCP();

  string fileName;
  string name;
  string categories;
  string tag;
  string pin;

  writef!"文件名: ";
  fileName = readln().replace("\n", "");

  writef!"名称: ";
  name = readln().replace("\n", "");

  writef!"分类:";
  categories = readln().replace("\n", "");

  writef!"标签:";
  tag = readln().replace("\n", "");

  writef!"pin(y/n):";
  pin = readln().replace("\n", "");

  if (tag.empty) {
    tag = categories;
  }

  string[] date = Clock.currTime().toISOExtString().split("T");
  string day = date[0];
  string time = date[1];

  string fn = day ~ "-" ~ fileName ~ ".md";
  string path = "_posts";

  write(path ~ "\\" ~ fn,
    base.format(
      name,
      day.replace("-", "/") ~ " " ~ time,
      categories,
      tag,
      pin == "y"
  ));
}
