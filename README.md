# Pong - Odin
## Known Issues
- Ball can get trapped inside the paddle somehow.
- Ball can bounce at an extreme angle somehow.
- Ball can phase through paddle when going too fast.
    - Proposed fix: Scan travelled path for collision.
- Score isn't centred properly.
    - Proposed fix: Separate score strings for more precise calculations.
- It's unfair to have the ball always shoot towards the right at first.
    - Proposed fix: Have it always shoot towards the winner.
