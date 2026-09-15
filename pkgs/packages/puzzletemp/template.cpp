#include <bits/stdc++.h>
using namespace std;

#define READ_VEC(name, type, size) \
    std::vector<type> name(size); \
    for (int i = 0; i < (size); i++) std::cin >> name[i];

template <typename... Args>
void println(Args&&... args)
{
    bool first = true;
    ((cout << (first ? "" : " ") << std::forward<Args>(args),
      first = false), ...);
    cout << '\n';
}


int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
}
