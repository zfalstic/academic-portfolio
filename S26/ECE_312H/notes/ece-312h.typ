#import "@preview/noteworthy:0.3.0": *

#show: noteworthy.with(
  paper-size: "us-letter",
  font: "New Computer Modern",
  language: "EN",
  title: "ECE 312H Notes",
  header-title: "ECE 312H",
  author: "Dawson Zhang",
  contact-details: "dawsonzhang@utexas",
  toc-title: "Table of Contents",
)

#show link: underline

#pagebreak()
= Templates

Consider the scenario where you have the following class.

```cpp
class Pair {
  int x;
  int y;
  
  Pair(int a, int b) {
    x = a;
    y = b;
  }
}
```

If we want to use this same ```cpp Pair``` class for 
a ```cpp float```, we won't be able to unless we make
a new class and define everything as a float. Instead,
here we can use a template.

```cpp
template<typename T, typename S>
class Pair {
  T x;
  S y;

  Pair(T a, S b) {
    x = a;
    y = b;
  }
}
```

Using this format, we could define any set of pairs.

- ```cpp Pair<int, int>```
- ```cpp Pair<float, char>```
- ```cpp Pair<double, float>```

== Function Templates

Templates can also be applied to free functions, not just classes.

```cpp
template<typename T>
T max(T a, T b) { return a > b ? a : b; }

max(3, 5);        // T inferred as int
max(1.2, 3.4);    // T inferred as double
```

== Non-Type Template Parameters

Template parameters can be values, not just types. The value becomes a compile-time constant inside the class.

```cpp
template<typename T, int N>
class Array {
  T data[N];
  int size() { return N; }
};

Array<int, 10> a;     // fixed-size array of 10 ints
Array<double, 3> b;   // fixed-size array of 3 doubles
```

#pagebreak()
= Containers

In C++, containers are production quality generic
data structures that can be used with any type
through templating.

#table(
  columns: (auto, auto),
  inset: 5pt,
  align: horizon,
  table.header(
    [*Container*], [*Description*],
  ),
  [```cpp vector<T>```],
  [dynamic array],
  [```cpp deque<T>```],
  [double-ended queue],
  [```cpp list<T>```],
  [double-linked list],
  [```cpp set<T>```],
  [group of unique elements with $O(log n)$ access and insertion],
  [```cpp map<T, S>```],
  [sorted key-value objected with $O(log n)$ access and insertion],
  [```cpp unordered_map<T, S>```],
  [hash table key-value with $O(1)$ access and insertion]
)

#heading(level: 3, numbering: none)[
  ```cpp std::vector```
]

```cpp
vector<int> scores = {90, 85, 92};
scores.push_back(88);       // append to end
scores.pop_back();          // remove from end
int first = scores[0];      // random access
```

#heading(level: 3, numbering: none)[
  ```cpp std::deque```
]

```cpp
deque<int> q = {2, 3, 4};
q.push_front(1);            // prepend to front
q.push_back(5);             // append to end
q.pop_front();              // remove from front
```

#heading(level: 3, numbering: none)[
  ```cpp std::list```
]

```cpp
list<int> nums = {1, 2, 3};
auto it = nums.begin();
advance(it, 1);
nums.insert(it, 99);        // insert 99 before position
nums.erase(it);             // erase element at position
```

#heading(level: 3, numbering: none)[
  ```cpp std::set```
]

```cpp
set<string> names;
names.insert("Alice");
names.insert("Bob");
names.insert("Alice");      // duplicate, ignored
bool found = names.count("Bob");  // 1 if present
```

#heading(level: 3, numbering: none)[
  ```cpp std::map```
]

```cpp
map<string, float> grades;
grades["Fred"] = 95;
grades["Lucy"] = 98;
float g = grades["Fred"];   // O(log n) lookup
```

#heading(level: 3, numbering: none)[
  ```cpp std::unordered_map```
]

```cpp
unordered_map<string, int> wordCount;
wordCount["hello"]++;
wordCount["world"]++;
int count = wordCount["hello"];  // O(1) lookup
```
