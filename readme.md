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

The numbers in [raw-results.md](raw-results.md) indicate the prestissmo plugin 
should make installing frameworks reliably faster

**Scenario 1**

Installs a large framework using create-project. 

- create project: 0m55.531s vs. 0m47.719s
   - 7.82 seconds faster (1.16×)
- install: 1m43.844s vs. 0m9.205s
   - 94.639 seconds faster (11.28×)

Notice how most of the speed increase occurs when resolving the framework 
dependencies.

**Scenario 2**

Installing last and current versions of popular frameworks. Assume that *some* 
dependencies will hit composer's cache, showing slightly more real-world timing
as certain packages are organically cached locally.

Comparisions (in order)

- Magento 2.1.5: 2m41.910s vs. 0m55.682s
   - 106.228 seconds faster (2.9×)
- Magento 2.1.6: 1m5.129s vs. 0m53.151s
   - 11.978 seconds faster (1.22×)
- Laravel 5.3: 1m54.431s vs. 0m48.737s
- Laravel 5.4: 0m29.506s vs. 0m16.867s
- Symfomy 2: 0m47.271s vs 0m14.129s
- Symfomy 3: 0m22.736s vs 0m13.836s

**Scenario 3**

To make it more explicit consecutive installs of the same packages will 
expereince less of a speed-up since they will be available locally.

- First run: 2m36.796s vs. 0m53.840s
   - 102.956 seconds faster (2.9×)
- Second run: 0m41.479s vs. 0m42.389s
   - 0.91 seconds **slower** (0.97×)
- Third run: 0m38.687s vs. 0m41.153s
   - 2.466 seconds **slower** (0.94×)

With a fully warmed cache it's clear that the plugin does add nominal overhead.

**Synopsis**

As stated these numbers aren't airtight but indicative of possible outcomes.

Annectodatley I can say the plugin makes day to day composer usage feel snappier 
and after months of usage I haven't encountered a single issue — it's a stable 
piece of software.

My recommendation: use the plugin!
