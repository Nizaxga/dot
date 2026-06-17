#include <cstdlib>
#include <iostream>
#include <vector>

std::vector<int> sieve(int n) {
  std::vector<bool> prime(n + 1, true);
  for (int p = 2; p * p <= n; p++) {
    if (prime[p]) {
      for (int i = p * p; i <= n; i += p)
        prime[i] = false;
    }
  }

  std::vector<int> res;
  for (int p = 2; p <= n; p++) {
    if (prime[p])
      res.push_back(p);
  }
  return res;
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    std::cerr << "Usage: " << argv[0] << " <number>" << '\n';
    return 1;
  }

  int n = atoi(argv[1]);
  std::vector<int> res = sieve(n);
  for (auto ele : res)
    std::cout << ele << ' ';
  std::cout << '\n';

  return 0;
}
