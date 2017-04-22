### Purpose

Compare composer installation times with and without the [prestissimo](https://github.com/hirak/prestissimo) plugin.

### Considerations

- We aim to have tests between environments with and without the plugin be consitent
- Composer's built in cache needs to be considered
- Everything is reproducible and tweakable — all assumptions should be evident

**Networking Caveat**

The hardest assumption to deal with is the network.

Testing network heavy code is tricky &ndash; especially when interacting with public networks. The approach here is admidtely 
a little naive, small sample sizes and an optimistic assumption that network responses are stable across runs undermines the 
empirical value of this test suite.

There is probably a way to remove these problems from the  testing but I'll dispense with that for now — I only have time to
do a "thoughtful glance" test.

### Running the tests

**Requirements**

- *nix enivornment with bash installed
- Vagrant (built using 1.9.2)
- VirtualBox (built using 5.1.10)

Assuming those are met clone the repo and run:

```
./test-prestissmo.sh
```

Everything happens inside the VM.

### Summary

The numbers in [raw-results.md](raw-results.md) indicate the prestissmo plugin should make installing frameworks reliably faster

Annectodatley I can say the plugin makes day to day composer usage feel snappier and after months of usage I haven't encountered a 
single issue — it's a stable piece of software

My recommendation: use the plugin!

