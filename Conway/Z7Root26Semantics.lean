import Conway.Z7Root26Core
import Init.Omega

namespace Matrix99.Z7Root26Model

open Std.Sat ConwayRoot26Pilot

set_option maxRecDepth 100000
set_option maxHeartbeats 8000000
set_option Elab.async false

structure Facts (x : Fin 12 → Nat) : Prop where
  bound : ∀ j, x j ≤ 4
  diagonal : x 11 = 0 ∨ x 11 = 2
  zero : x 0 = 3
  total : x 0+x 1+x 2+x 3+x 4+x 5+x 6+x 7+x 8+x 9+x 10+x 11 = 12
  balance : x 0+x 1+x 2 = x 3+x 4+x 5
  dot : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12
  square : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+
    x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24

def assignment (x : Fin 12 → Nat) (identifier : Nat) : Bool :=
  match identifier with
  | 1 => decide ((0 : Int) = (0 : Int))
  | 3 => decide (((2 : Int)) = (2 : Int))
  | 4 => decide ((0 : Int) = (0 : Int))
  | 10 => decide (((1 : Int)) = (1 : Int))
  | 15 => decide (((1 : Int)) = (1 : Int))
  | 20 => decide (((1 : Int)) = (1 : Int))
  | 25 => decide (((1 : Int)) = (1 : Int))
  | 29 => decide ((0 : Int) = (0 : Int))
  | 34 => decide ((0 : Int) = (0 : Int))
  | 40 => decide (((1 : Int)) = (1 : Int))
  | 45 => decide (((1 : Int)) = (1 : Int))
  | 50 => decide (((1 : Int)) = (1 : Int))
  | 57 => decide (((3 : Int)) = (3 : Int))
  | 106 => decide (((x 1 : Int)) = (0 : Int))
  | 107 => decide (((x 1 : Int)) = (1 : Int))
  | 108 => decide (((x 1 : Int)) = (2 : Int))
  | 109 => decide (((x 1 : Int)) = (3 : Int))
  | 110 => decide (((x 1 : Int)) = (4 : Int))
  | 153 => decide (((x 2 : Int)) = (0 : Int))
  | 154 => decide (((x 2 : Int)) = (1 : Int))
  | 155 => decide (((x 2 : Int)) = (2 : Int))
  | 156 => decide (((x 2 : Int)) = (3 : Int))
  | 157 => decide (((x 2 : Int)) = (4 : Int))
  | 195 => decide (((x 3 : Int)) = (0 : Int))
  | 196 => decide (((x 3 : Int)) = (1 : Int))
  | 197 => decide (((x 3 : Int)) = (2 : Int))
  | 198 => decide (((x 3 : Int)) = (3 : Int))
  | 199 => decide (((x 3 : Int)) = (4 : Int))
  | 232 => decide (((x 4 : Int)) = (0 : Int))
  | 233 => decide (((x 4 : Int)) = (1 : Int))
  | 234 => decide (((x 4 : Int)) = (2 : Int))
  | 235 => decide (((x 4 : Int)) = (3 : Int))
  | 236 => decide (((x 4 : Int)) = (4 : Int))
  | 264 => decide (((x 5 : Int)) = (0 : Int))
  | 265 => decide (((x 5 : Int)) = (1 : Int))
  | 266 => decide (((x 5 : Int)) = (2 : Int))
  | 267 => decide (((x 5 : Int)) = (3 : Int))
  | 268 => decide (((x 5 : Int)) = (4 : Int))
  | 291 => decide (((x 6 : Int)) = (0 : Int))
  | 292 => decide (((x 6 : Int)) = (1 : Int))
  | 293 => decide (((x 6 : Int)) = (2 : Int))
  | 294 => decide (((x 6 : Int)) = (3 : Int))
  | 295 => decide (((x 6 : Int)) = (4 : Int))
  | 313 => decide (((x 7 : Int)) = (0 : Int))
  | 314 => decide (((x 7 : Int)) = (1 : Int))
  | 315 => decide (((x 7 : Int)) = (2 : Int))
  | 316 => decide (((x 7 : Int)) = (3 : Int))
  | 317 => decide (((x 7 : Int)) = (4 : Int))
  | 330 => decide (((x 8 : Int)) = (0 : Int))
  | 331 => decide (((x 8 : Int)) = (1 : Int))
  | 332 => decide (((x 8 : Int)) = (2 : Int))
  | 333 => decide (((x 8 : Int)) = (3 : Int))
  | 334 => decide (((x 8 : Int)) = (4 : Int))
  | 342 => decide (((x 9 : Int)) = (0 : Int))
  | 343 => decide (((x 9 : Int)) = (1 : Int))
  | 344 => decide (((x 9 : Int)) = (2 : Int))
  | 345 => decide (((x 9 : Int)) = (3 : Int))
  | 346 => decide (((x 9 : Int)) = (4 : Int))
  | 349 => decide (((x 10 : Int)) = (0 : Int))
  | 350 => decide (((x 10 : Int)) = (1 : Int))
  | 351 => decide (((x 10 : Int)) = (2 : Int))
  | 352 => decide (((x 10 : Int)) = (3 : Int))
  | 353 => decide (((x 10 : Int)) = (4 : Int))
  | 354 => decide (((x 11 : Int)) = (0 : Int))
  | 355 => decide (((x 11 : Int)) = (2 : Int))
  | 2877 => decide (((3 : Int)) = (3 : Int))
  | 2882 => decide (((3 : Int) + (x 1 : Int)) = (3 : Int))
  | 2883 => decide (((3 : Int) + (x 1 : Int)) = (4 : Int))
  | 2885 => decide (((3 : Int) + (x 1 : Int)) = (6 : Int))
  | 2891 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int))
  | 2894 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int))
  | 2904 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int))
  | 2905 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (4 : Int))
  | 2906 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (5 : Int))
  | 2907 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int))
  | 2909 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int))
  | 2917 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (3 : Int))
  | 2918 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (4 : Int))
  | 2919 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (5 : Int))
  | 2920 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (6 : Int))
  | 2933 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int))
  | 2946 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int))
  | 2947 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int))
  | 2948 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int))
  | 2949 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int))
  | 2959 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (6 : Int))
  | 2960 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (7 : Int))
  | 2961 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (8 : Int))
  | 2962 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (9 : Int))
  | 2963 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (10 : Int))
  | 2964 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (11 : Int))
  | 2972 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (6 : Int))
  | 2973 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (7 : Int))
  | 2974 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (8 : Int))
  | 2975 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (9 : Int))
  | 2976 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (10 : Int))
  | 2977 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (11 : Int))
  | 2985 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int))
  | 2986 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (7 : Int))
  | 2987 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (8 : Int))
  | 2988 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int))
  | 2989 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int))
  | 2990 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int))
  | 2998 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (6 : Int))
  | 2999 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (7 : Int))
  | 3000 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (8 : Int))
  | 3001 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (9 : Int))
  | 3002 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int))
  | 3003 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int))
  | 3011 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (6 : Int))
  | 3012 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (7 : Int))
  | 3013 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (8 : Int))
  | 3014 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (9 : Int))
  | 3015 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (10 : Int))
  | 3016 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (11 : Int))
  | 3017 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int))
  | 3021 => decide (((3 : Int)) = (3 : Int))
  | 3026 => decide (((3 : Int) + (x 1 : Int)) = (3 : Int))
  | 3027 => decide (((3 : Int) + (x 1 : Int)) = (4 : Int))
  | 3028 => decide (((3 : Int) + (x 1 : Int)) = (5 : Int))
  | 3029 => decide (((3 : Int) + (x 1 : Int)) = (6 : Int))
  | 3035 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int))
  | 3036 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int))
  | 3037 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int))
  | 3038 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int))
  | 3039 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int))
  | 3040 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int))
  | 3041 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (9 : Int))
  | 3050 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (1 : Int))
  | 3051 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (2 : Int))
  | 3052 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (3 : Int))
  | 3053 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int))
  | 3054 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int))
  | 3055 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int))
  | 3056 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (7 : Int))
  | 3057 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (8 : Int))
  | 3058 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (9 : Int))
  | 3071 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (1 : Int))
  | 3072 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (2 : Int))
  | 3073 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int))
  | 3074 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int))
  | 3075 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int))
  | 3076 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int))
  | 3077 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (7 : Int))
  | 3078 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (8 : Int))
  | 3079 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (9 : Int))
  | 3083 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int))
  | 3084 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (-1 : Int))
  | 3096 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (1 : Int))
  | 3097 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (2 : Int))
  | 3098 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (3 : Int))
  | 3099 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (4 : Int))
  | 3100 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (5 : Int))
  | 3101 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (6 : Int))
  | 3102 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (7 : Int))
  | 3103 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (8 : Int))
  | 3104 => decide (((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (9 : Int))
  | 6222 => decide (((6 : Int)) = (6 : Int))
  | 6224 => decide ((0 : Int) = (0 : Int))
  | 6234 => decide (((x 2 : Int)) = (0 : Int))
  | 6235 => decide (((x 2 : Int)) = (1 : Int))
  | 6236 => decide (((x 2 : Int)) = (2 : Int))
  | 6237 => decide (((x 2 : Int)) = (3 : Int))
  | 6238 => decide (((x 2 : Int)) = (4 : Int))
  | 6239 => decide (((x 2 : Int)) = (6 : Int))
  | 6240 => decide (((x 2 : Int)) = (8 : Int))
  | 6241 => decide (((x 2 : Int)) = (9 : Int))
  | 6242 => decide (((x 2 : Int)) = (12 : Int))
  | 6243 => decide (((x 2 : Int)) = (16 : Int))
  | 6244 => decide (((x 3 : Int)) = (0 : Int))
  | 6245 => decide (((x 3 : Int)) = (1 : Int))
  | 6246 => decide (((x 3 : Int)) = (2 : Int))
  | 6247 => decide (((x 3 : Int)) = (3 : Int))
  | 6248 => decide (((x 3 : Int)) = (4 : Int))
  | 6254 => decide (((x 4 : Int)) = (0 : Int))
  | 6255 => decide (((x 4 : Int)) = (1 : Int))
  | 6256 => decide (((x 4 : Int)) = (2 : Int))
  | 6257 => decide (((x 4 : Int)) = (3 : Int))
  | 6258 => decide (((x 4 : Int)) = (4 : Int))
  | 6264 => decide (((x 5 : Int)) = (0 : Int))
  | 6265 => decide (((x 5 : Int)) = (1 : Int))
  | 6266 => decide (((x 5 : Int)) = (2 : Int))
  | 6267 => decide (((x 5 : Int)) = (3 : Int))
  | 6268 => decide (((x 5 : Int)) = (4 : Int))
  | 6274 => decide ((0 : Int) = (0 : Int))
  | 6284 => decide ((0 : Int) = (0 : Int))
  | 6294 => decide (((x 8 : Int)) = (0 : Int))
  | 6295 => decide (((x 8 : Int)) = (1 : Int))
  | 6296 => decide (((x 8 : Int)) = (2 : Int))
  | 6297 => decide (((x 8 : Int)) = (3 : Int))
  | 6298 => decide (((x 8 : Int)) = (4 : Int))
  | 6299 => decide (((x 8 : Int)) = (6 : Int))
  | 6300 => decide (((x 8 : Int)) = (8 : Int))
  | 6301 => decide (((x 8 : Int)) = (9 : Int))
  | 6302 => decide (((x 8 : Int)) = (12 : Int))
  | 6303 => decide (((x 8 : Int)) = (16 : Int))
  | 6304 => decide (((x 9 : Int)) = (0 : Int))
  | 6305 => decide (((x 9 : Int)) = (1 : Int))
  | 6306 => decide (((x 9 : Int)) = (2 : Int))
  | 6307 => decide (((x 9 : Int)) = (3 : Int))
  | 6308 => decide (((x 9 : Int)) = (4 : Int))
  | 6309 => decide (((x 9 : Int)) = (6 : Int))
  | 6310 => decide (((x 9 : Int)) = (8 : Int))
  | 6311 => decide (((x 9 : Int)) = (9 : Int))
  | 6312 => decide (((x 9 : Int)) = (12 : Int))
  | 6313 => decide (((x 9 : Int)) = (16 : Int))
  | 6314 => decide (((x 10 : Int)) = (0 : Int))
  | 6315 => decide (((x 10 : Int)) = (1 : Int))
  | 6316 => decide (((x 10 : Int)) = (2 : Int))
  | 6317 => decide (((x 10 : Int)) = (3 : Int))
  | 6318 => decide (((x 10 : Int)) = (4 : Int))
  | 6319 => decide (((x 10 : Int)) = (6 : Int))
  | 6320 => decide (((x 10 : Int)) = (8 : Int))
  | 6321 => decide (((x 10 : Int)) = (9 : Int))
  | 6322 => decide (((x 10 : Int)) = (12 : Int))
  | 6323 => decide (((x 10 : Int)) = (16 : Int))
  | 6324 => decide (((3 * (x 11 : Int))) = (0 : Int))
  | 6325 => decide (((3 * (x 11 : Int))) = (2 : Int))
  | 6326 => decide (((3 * (x 11 : Int))) = (4 : Int))
  | 6327 => decide (((3 * (x 11 : Int))) = (6 : Int))
  | 6328 => decide (((3 * (x 11 : Int))) = (8 : Int))
  | 6332 => decide (((6 : Int)) = (6 : Int))
  | 6339 => decide (((6 : Int)) = (6 : Int))
  | 6352 => decide (((6 : Int) + (x 2 : Int)) = (6 : Int))
  | 6353 => decide (((6 : Int) + (x 2 : Int)) = (8 : Int))
  | 6354 => decide (((6 : Int) + (x 2 : Int)) = (9 : Int))
  | 6355 => decide (((6 : Int) + (x 2 : Int)) = (12 : Int))
  | 6357 => decide (((6 : Int) + (x 2 : Int)) = (7 : Int))
  | 6358 => decide (((6 : Int) + (x 2 : Int)) = (10 : Int))
  | 6365 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int))
  | 6366 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int))
  | 6367 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int))
  | 6368 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int))
  | 6370 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int))
  | 6371 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int))
  | 6372 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int))
  | 6378 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (6 : Int))
  | 6379 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int))
  | 6380 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int))
  | 6381 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int))
  | 6383 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (7 : Int))
  | 6384 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int))
  | 6385 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int))
  | 6393 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int))
  | 6394 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int))
  | 6397 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int))
  | 6398 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int))
  | 6406 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int))
  | 6407 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int))
  | 6410 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int))
  | 6411 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int))
  | 6419 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int))
  | 6420 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int))
  | 6423 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int))
  | 6424 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int))
  | 6432 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int))
  | 6433 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int))
  | 6436 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int))
  | 6437 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int))
  | 6445 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int))
  | 6446 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int))
  | 6449 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int))
  | 6450 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int))
  | 6458 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (9 : Int))
  | 6459 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int))
  | 6462 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int))
  | 6463 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int))
  | 6474 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (10 : Int))
  | 6475 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (11 : Int))
  | 6476 => decide (((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (12 : Int))
  | 25753 => decide (((9 : Int)) = (9 : Int))
  | 25756 => decide ((((x 1 * x 1 : Nat) : Int)) = (0 : Int))
  | 25757 => decide ((((x 1 * x 1 : Nat) : Int)) = (1 : Int))
  | 25758 => decide ((((x 1 * x 1 : Nat) : Int)) = (2 : Int))
  | 25759 => decide ((((x 1 * x 1 : Nat) : Int)) = (3 : Int))
  | 25760 => decide ((((x 1 * x 1 : Nat) : Int)) = (4 : Int))
  | 25761 => decide ((((x 1 * x 1 : Nat) : Int)) = (6 : Int))
  | 25762 => decide ((((x 1 * x 1 : Nat) : Int)) = (8 : Int))
  | 25763 => decide ((((x 1 * x 1 : Nat) : Int)) = (9 : Int))
  | 25764 => decide ((((x 1 * x 1 : Nat) : Int)) = (12 : Int))
  | 25765 => decide ((((x 1 * x 1 : Nat) : Int)) = (16 : Int))
  | 25766 => decide ((((x 2 * x 2 : Nat) : Int)) = (0 : Int))
  | 25767 => decide ((((x 2 * x 2 : Nat) : Int)) = (1 : Int))
  | 25770 => decide ((((x 2 * x 2 : Nat) : Int)) = (4 : Int))
  | 25775 => decide ((((x 2 * x 2 : Nat) : Int)) = (16 : Int))
  | 25776 => decide ((((x 3 * x 3 : Nat) : Int)) = (0 : Int))
  | 25777 => decide ((((x 3 * x 3 : Nat) : Int)) = (1 : Int))
  | 25780 => decide ((((x 3 * x 3 : Nat) : Int)) = (4 : Int))
  | 25783 => decide ((((x 3 * x 3 : Nat) : Int)) = (9 : Int))
  | 25785 => decide ((((x 3 * x 3 : Nat) : Int)) = (16 : Int))
  | 25786 => decide ((((x 4 * x 4 : Nat) : Int)) = (0 : Int))
  | 25787 => decide ((((x 4 * x 4 : Nat) : Int)) = (1 : Int))
  | 25790 => decide ((((x 4 * x 4 : Nat) : Int)) = (4 : Int))
  | 25793 => decide ((((x 4 * x 4 : Nat) : Int)) = (9 : Int))
  | 25795 => decide ((((x 4 * x 4 : Nat) : Int)) = (16 : Int))
  | 25796 => decide ((((x 5 * x 5 : Nat) : Int)) = (0 : Int))
  | 25797 => decide ((((x 5 * x 5 : Nat) : Int)) = (1 : Int))
  | 25800 => decide ((((x 5 * x 5 : Nat) : Int)) = (4 : Int))
  | 25803 => decide ((((x 5 * x 5 : Nat) : Int)) = (9 : Int))
  | 25806 => decide ((((x 6 * x 6 : Nat) : Int)) = (0 : Int))
  | 25810 => decide ((((x 6 * x 6 : Nat) : Int)) = (4 : Int))
  | 25813 => decide ((((x 6 * x 6 : Nat) : Int)) = (9 : Int))
  | 25815 => decide ((((x 6 * x 6 : Nat) : Int)) = (16 : Int))
  | 25816 => decide ((((x 7 * x 7 : Nat) : Int)) = (0 : Int))
  | 25817 => decide ((((x 7 * x 7 : Nat) : Int)) = (1 : Int))
  | 25820 => decide ((((x 7 * x 7 : Nat) : Int)) = (4 : Int))
  | 25823 => decide ((((x 7 * x 7 : Nat) : Int)) = (9 : Int))
  | 25825 => decide ((((x 7 * x 7 : Nat) : Int)) = (16 : Int))
  | 25826 => decide ((((x 8 * x 8 : Nat) : Int)) = (0 : Int))
  | 25827 => decide ((((x 8 * x 8 : Nat) : Int)) = (1 : Int))
  | 25830 => decide ((((x 8 * x 8 : Nat) : Int)) = (4 : Int))
  | 25833 => decide ((((x 8 * x 8 : Nat) : Int)) = (9 : Int))
  | 25835 => decide ((((x 8 * x 8 : Nat) : Int)) = (16 : Int))
  | 25836 => decide ((((x 9 * x 9 : Nat) : Int)) = (0 : Int))
  | 25846 => decide ((((x 10 * x 10 : Nat) : Int)) = (0 : Int))
  | 25847 => decide ((((x 10 * x 10 : Nat) : Int)) = (1 : Int))
  | 25850 => decide ((((x 10 * x 10 : Nat) : Int)) = (4 : Int))
  | 25853 => decide ((((x 10 * x 10 : Nat) : Int)) = (9 : Int))
  | 25855 => decide ((((x 10 * x 10 : Nat) : Int)) = (16 : Int))
  | 25856 => decide ((((x 11 * x 11 : Nat) : Int)) = (0 : Int))
  | 25865 => decide (((9 : Int)) = (9 : Int))
  | 25875 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int))
  | 25876 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (12 : Int))
  | 25880 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int))
  | 25881 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int))
  | 25882 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (17 : Int))
  | 25883 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (11 : Int))
  | 25885 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int))
  | 25886 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (15 : Int))
  | 25891 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (21 : Int))
  | 25899 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int))
  | 25900 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int))
  | 25901 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (16 : Int))
  | 25904 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int))
  | 25905 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int))
  | 25906 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int))
  | 25907 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int))
  | 25908 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int))
  | 25909 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int))
  | 25910 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (15 : Int))
  | 25911 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (19 : Int))
  | 25913 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (22 : Int))
  | 25915 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (21 : Int))
  | 25924 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int))
  | 25925 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (12 : Int))
  | 25926 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (16 : Int))
  | 25929 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int))
  | 25930 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (13 : Int))
  | 25931 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (17 : Int))
  | 25932 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (11 : Int))
  | 25933 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (14 : Int))
  | 25934 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (18 : Int))
  | 25935 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (15 : Int))
  | 25936 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (19 : Int))
  | 25937 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (20 : Int))
  | 25938 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (22 : Int))
  | 25940 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (21 : Int))
  | 25941 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (23 : Int))
  | 25949 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (9 : Int))
  | 25954 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (10 : Int))
  | 25955 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (13 : Int))
  | 25957 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (11 : Int))
  | 25958 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (14 : Int))
  | 25959 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (18 : Int))
  | 25975 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (12 : Int))
  | 25983 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int))
  | 25984 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (18 : Int))
  | 26001 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (16 : Int))
  | 26008 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int))
  | 26009 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (18 : Int))
  | 26013 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (22 : Int))
  | 26015 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (21 : Int))
  | 26016 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (23 : Int))
  | 26026 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int))
  | 26031 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (17 : Int))
  | 26033 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (14 : Int))
  | 26034 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (18 : Int))
  | 26035 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (15 : Int))
  | 26037 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (20 : Int))
  | 26038 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (22 : Int))
  | 26041 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (23 : Int))
  | 26056 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (17 : Int))
  | 26058 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (14 : Int))
  | 26059 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (18 : Int))
  | 26060 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (15 : Int))
  | 26062 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (20 : Int))
  | 26063 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (22 : Int))
  | 26066 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (23 : Int))
  | 26081 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (17 : Int))
  | 26083 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int))
  | 26084 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (18 : Int))
  | 26085 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (15 : Int))
  | 26087 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (20 : Int))
  | 26088 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (22 : Int))
  | 26091 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (23 : Int))
  | 26106 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (17 : Int))
  | 26108 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (14 : Int))
  | 26109 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (18 : Int))
  | 26110 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (15 : Int))
  | 26112 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (20 : Int))
  | 26113 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (22 : Int))
  | 26116 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (23 : Int))
  | 26131 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (20 : Int))
  | 26133 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (14 : Int))
  | 26134 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (17 : Int))
  | 26136 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (15 : Int))
  | 26137 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (18 : Int))
  | 26138 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (22 : Int))
  | 26140 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (23 : Int))
  | 26154 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (14 : Int))
  | 26157 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (15 : Int))
  | 26159 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (18 : Int))
  | 26160 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (20 : Int))
  | 26161 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (22 : Int))
  | 26162 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (17 : Int))
  | 26165 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (23 : Int))
  | 26166 => decide (((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int))
  | _ => false

private theorem fiveCases (a : Nat) (h : a ≤ 4) :
    a = 0 ∨ a = 1 ∨ a = 2 ∨ a = 3 ∨ a = 4 := by
  have finite : ∀ v : Fin 5, v.val = 0 ∨ v.val = 1 ∨ v.val = 2 ∨ v.val = 3 ∨ v.val = 4 := by decide
  exact finite ⟨a, Nat.lt_succ_of_le h⟩

private theorem arith_1 (x : Fin 12 → Nat)
    (g0 : (0 : Int) ≠ (0 : Int)) : False := by
  omega

theorem clause_1 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(1, true)] := by
  refine if hc : Holds (assignment x) [(1, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (1, true) ∈ [(1, true)])))
    exact False.elim (arith_1 x g0)

private theorem arith_2 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : ((x 1 : Int)) ≠ (2 : Int)) (g1 : ((x 1 : Int)) ≠ (1 : Int)) (g2 : ((x 1 : Int)) ≠ (3 : Int)) (g3 : ((x 1 : Int)) ≠ (0 : Int)) (g4 : ((x 1 : Int)) ≠ (4 : Int)) : False := by
  omega

theorem clause_2 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(108, true), (107, true), (109, true), (106, true), (110, true)] := by
  refine if hc : Holds (assignment x) [(108, true), (107, true), (109, true), (106, true), (110, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 1 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (108, true) ∈ [(108, true), (107, true), (109, true), (106, true), (110, true)])))
    have g1 : ((x 1 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (107, true) ∈ [(108, true), (107, true), (109, true), (106, true), (110, true)])))
    have g2 : ((x 1 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (109, true) ∈ [(108, true), (107, true), (109, true), (106, true), (110, true)])))
    have g3 : ((x 1 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (106, true) ∈ [(108, true), (107, true), (109, true), (106, true), (110, true)])))
    have g4 : ((x 1 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (110, true) ∈ [(108, true), (107, true), (109, true), (106, true), (110, true)])))
    exact False.elim (arith_2 x (h.bound 1) g0 g1 g2 g3 g4)

private theorem arith_3 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) ≠ (3 : Int)) (g1 : ((x 2 : Int)) ≠ (4 : Int)) (g2 : ((x 2 : Int)) ≠ (1 : Int)) (g3 : ((x 2 : Int)) ≠ (0 : Int)) (g4 : ((x 2 : Int)) ≠ (2 : Int)) : False := by
  omega

theorem clause_3 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(156, true), (157, true), (154, true), (153, true), (155, true)] := by
  refine if hc : Holds (assignment x) [(156, true), (157, true), (154, true), (153, true), (155, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (156, true) ∈ [(156, true), (157, true), (154, true), (153, true), (155, true)])))
    have g1 : ((x 2 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (157, true) ∈ [(156, true), (157, true), (154, true), (153, true), (155, true)])))
    have g2 : ((x 2 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (154, true) ∈ [(156, true), (157, true), (154, true), (153, true), (155, true)])))
    have g3 : ((x 2 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (153, true) ∈ [(156, true), (157, true), (154, true), (153, true), (155, true)])))
    have g4 : ((x 2 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (155, true) ∈ [(156, true), (157, true), (154, true), (153, true), (155, true)])))
    exact False.elim (arith_3 x (h.bound 2) g0 g1 g2 g3 g4)

private theorem arith_4 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) = (2 : Int)) (g1 : ((x 2 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_4 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(155, false), (153, false)] := by
  refine if hc : Holds (assignment x) [(155, false), (153, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (155, false) ∈ [(155, false), (153, false)])))
    have g1 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(155, false), (153, false)])))
    exact False.elim (arith_4 x (h.bound 2) g0 g1)

private theorem arith_5 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) = (3 : Int)) (g1 : ((x 2 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_5 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(156, false), (153, false)] := by
  refine if hc : Holds (assignment x) [(156, false), (153, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (156, false) ∈ [(156, false), (153, false)])))
    have g1 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(156, false), (153, false)])))
    exact False.elim (arith_5 x (h.bound 2) g0 g1)

private theorem arith_6 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) = (3 : Int)) (g1 : ((x 2 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_6 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(156, false), (154, false)] := by
  refine if hc : Holds (assignment x) [(156, false), (154, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (156, false) ∈ [(156, false), (154, false)])))
    have g1 : ((x 2 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (154, false) ∈ [(156, false), (154, false)])))
    exact False.elim (arith_6 x (h.bound 2) g0 g1)

private theorem arith_7 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) ≠ (2 : Int)) (g1 : ((x 3 : Int)) ≠ (3 : Int)) (g2 : ((x 3 : Int)) ≠ (4 : Int)) (g3 : ((x 3 : Int)) ≠ (1 : Int)) (g4 : ((x 3 : Int)) ≠ (0 : Int)) : False := by
  omega

theorem clause_7 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(197, true), (198, true), (199, true), (196, true), (195, true)] := by
  refine if hc : Holds (assignment x) [(197, true), (198, true), (199, true), (196, true), (195, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (197, true) ∈ [(197, true), (198, true), (199, true), (196, true), (195, true)])))
    have g1 : ((x 3 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (198, true) ∈ [(197, true), (198, true), (199, true), (196, true), (195, true)])))
    have g2 : ((x 3 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (199, true) ∈ [(197, true), (198, true), (199, true), (196, true), (195, true)])))
    have g3 : ((x 3 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (196, true) ∈ [(197, true), (198, true), (199, true), (196, true), (195, true)])))
    have g4 : ((x 3 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (195, true) ∈ [(197, true), (198, true), (199, true), (196, true), (195, true)])))
    exact False.elim (arith_7 x (h.bound 3) g0 g1 g2 g3 g4)

private theorem arith_8 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) = (2 : Int)) (g1 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_8 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(197, false), (195, false)] := by
  refine if hc : Holds (assignment x) [(197, false), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(197, false), (195, false)])))
    have g1 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(197, false), (195, false)])))
    exact False.elim (arith_8 x (h.bound 3) g0 g1)

private theorem arith_9 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) ≠ (4 : Int)) (g1 : ((x 4 : Int)) ≠ (0 : Int)) (g2 : ((x 4 : Int)) ≠ (3 : Int)) (g3 : ((x 4 : Int)) ≠ (1 : Int)) (g4 : ((x 4 : Int)) ≠ (2 : Int)) : False := by
  omega

theorem clause_9 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(236, true), (232, true), (235, true), (233, true), (234, true)] := by
  refine if hc : Holds (assignment x) [(236, true), (232, true), (235, true), (233, true), (234, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (236, true) ∈ [(236, true), (232, true), (235, true), (233, true), (234, true)])))
    have g1 : ((x 4 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (232, true) ∈ [(236, true), (232, true), (235, true), (233, true), (234, true)])))
    have g2 : ((x 4 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (235, true) ∈ [(236, true), (232, true), (235, true), (233, true), (234, true)])))
    have g3 : ((x 4 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (233, true) ∈ [(236, true), (232, true), (235, true), (233, true), (234, true)])))
    have g4 : ((x 4 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (234, true) ∈ [(236, true), (232, true), (235, true), (233, true), (234, true)])))
    exact False.elim (arith_9 x (h.bound 4) g0 g1 g2 g3 g4)

private theorem arith_10 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) ≠ (0 : Int)) (g1 : ((x 5 : Int)) ≠ (4 : Int)) (g2 : ((x 5 : Int)) ≠ (3 : Int)) (g3 : ((x 5 : Int)) ≠ (1 : Int)) (g4 : ((x 5 : Int)) ≠ (2 : Int)) : False := by
  omega

theorem clause_10 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(264, true), (268, true), (267, true), (265, true), (266, true)] := by
  refine if hc : Holds (assignment x) [(264, true), (268, true), (267, true), (265, true), (266, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (264, true) ∈ [(264, true), (268, true), (267, true), (265, true), (266, true)])))
    have g1 : ((x 5 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (268, true) ∈ [(264, true), (268, true), (267, true), (265, true), (266, true)])))
    have g2 : ((x 5 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (267, true) ∈ [(264, true), (268, true), (267, true), (265, true), (266, true)])))
    have g3 : ((x 5 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (265, true) ∈ [(264, true), (268, true), (267, true), (265, true), (266, true)])))
    have g4 : ((x 5 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (266, true) ∈ [(264, true), (268, true), (267, true), (265, true), (266, true)])))
    exact False.elim (arith_10 x (h.bound 5) g0 g1 g2 g3 g4)

private theorem arith_11 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : ((x 6 : Int)) ≠ (3 : Int)) (g1 : ((x 6 : Int)) ≠ (0 : Int)) (g2 : ((x 6 : Int)) ≠ (1 : Int)) (g3 : ((x 6 : Int)) ≠ (2 : Int)) (g4 : ((x 6 : Int)) ≠ (4 : Int)) : False := by
  omega

theorem clause_11 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(294, true), (291, true), (292, true), (293, true), (295, true)] := by
  refine if hc : Holds (assignment x) [(294, true), (291, true), (292, true), (293, true), (295, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 6 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (294, true) ∈ [(294, true), (291, true), (292, true), (293, true), (295, true)])))
    have g1 : ((x 6 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (291, true) ∈ [(294, true), (291, true), (292, true), (293, true), (295, true)])))
    have g2 : ((x 6 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (292, true) ∈ [(294, true), (291, true), (292, true), (293, true), (295, true)])))
    have g3 : ((x 6 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (293, true) ∈ [(294, true), (291, true), (292, true), (293, true), (295, true)])))
    have g4 : ((x 6 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (295, true) ∈ [(294, true), (291, true), (292, true), (293, true), (295, true)])))
    exact False.elim (arith_11 x (h.bound 6) g0 g1 g2 g3 g4)

private theorem arith_12 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : ((x 7 : Int)) ≠ (1 : Int)) (g1 : ((x 7 : Int)) ≠ (2 : Int)) (g2 : ((x 7 : Int)) ≠ (4 : Int)) (g3 : ((x 7 : Int)) ≠ (3 : Int)) (g4 : ((x 7 : Int)) ≠ (0 : Int)) : False := by
  omega

theorem clause_12 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(314, true), (315, true), (317, true), (316, true), (313, true)] := by
  refine if hc : Holds (assignment x) [(314, true), (315, true), (317, true), (316, true), (313, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (314, true) ∈ [(314, true), (315, true), (317, true), (316, true), (313, true)])))
    have g1 : ((x 7 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (315, true) ∈ [(314, true), (315, true), (317, true), (316, true), (313, true)])))
    have g2 : ((x 7 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (317, true) ∈ [(314, true), (315, true), (317, true), (316, true), (313, true)])))
    have g3 : ((x 7 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (316, true) ∈ [(314, true), (315, true), (317, true), (316, true), (313, true)])))
    have g4 : ((x 7 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (313, true) ∈ [(314, true), (315, true), (317, true), (316, true), (313, true)])))
    exact False.elim (arith_12 x (h.bound 7) g0 g1 g2 g3 g4)

private theorem arith_13 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) ≠ (4 : Int)) (g1 : ((x 8 : Int)) ≠ (3 : Int)) (g2 : ((x 8 : Int)) ≠ (0 : Int)) (g3 : ((x 8 : Int)) ≠ (2 : Int)) (g4 : ((x 8 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_13 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(334, true), (333, true), (330, true), (332, true), (331, true)] := by
  refine if hc : Holds (assignment x) [(334, true), (333, true), (330, true), (332, true), (331, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (334, true) ∈ [(334, true), (333, true), (330, true), (332, true), (331, true)])))
    have g1 : ((x 8 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (333, true) ∈ [(334, true), (333, true), (330, true), (332, true), (331, true)])))
    have g2 : ((x 8 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (330, true) ∈ [(334, true), (333, true), (330, true), (332, true), (331, true)])))
    have g3 : ((x 8 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (332, true) ∈ [(334, true), (333, true), (330, true), (332, true), (331, true)])))
    have g4 : ((x 8 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (331, true) ∈ [(334, true), (333, true), (330, true), (332, true), (331, true)])))
    exact False.elim (arith_13 x (h.bound 8) g0 g1 g2 g3 g4)

private theorem arith_14 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) ≠ (2 : Int)) (g1 : ((x 9 : Int)) ≠ (1 : Int)) (g2 : ((x 9 : Int)) ≠ (0 : Int)) (g3 : ((x 9 : Int)) ≠ (3 : Int)) (g4 : ((x 9 : Int)) ≠ (4 : Int)) : False := by
  omega

theorem clause_14 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(344, true), (343, true), (342, true), (345, true), (346, true)] := by
  refine if hc : Holds (assignment x) [(344, true), (343, true), (342, true), (345, true), (346, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (344, true) ∈ [(344, true), (343, true), (342, true), (345, true), (346, true)])))
    have g1 : ((x 9 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (343, true) ∈ [(344, true), (343, true), (342, true), (345, true), (346, true)])))
    have g2 : ((x 9 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (342, true) ∈ [(344, true), (343, true), (342, true), (345, true), (346, true)])))
    have g3 : ((x 9 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (345, true) ∈ [(344, true), (343, true), (342, true), (345, true), (346, true)])))
    have g4 : ((x 9 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (346, true) ∈ [(344, true), (343, true), (342, true), (345, true), (346, true)])))
    exact False.elim (arith_14 x (h.bound 9) g0 g1 g2 g3 g4)

private theorem arith_15 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : ((x 10 : Int)) ≠ (0 : Int)) (g1 : ((x 10 : Int)) ≠ (3 : Int)) (g2 : ((x 10 : Int)) ≠ (4 : Int)) (g3 : ((x 10 : Int)) ≠ (2 : Int)) (g4 : ((x 10 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_15 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(349, true), (352, true), (353, true), (351, true), (350, true)] := by
  refine if hc : Holds (assignment x) [(349, true), (352, true), (353, true), (351, true), (350, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (349, true) ∈ [(349, true), (352, true), (353, true), (351, true), (350, true)])))
    have g1 : ((x 10 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (352, true) ∈ [(349, true), (352, true), (353, true), (351, true), (350, true)])))
    have g2 : ((x 10 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (353, true) ∈ [(349, true), (352, true), (353, true), (351, true), (350, true)])))
    have g3 : ((x 10 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (351, true) ∈ [(349, true), (352, true), (353, true), (351, true), (350, true)])))
    have g4 : ((x 10 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (350, true) ∈ [(349, true), (352, true), (353, true), (351, true), (350, true)])))
    exact False.elim (arith_15 x (h.bound 10) g0 g1 g2 g3 g4)

private theorem arith_16 (x : Fin 12 → Nat)
    (hb : x 11 ≤ 4) (hd : x 11 = 0 ∨ x 11 = 2) (g0 : ((x 11 : Int)) ≠ (2 : Int)) (g1 : ((x 11 : Int)) ≠ (0 : Int)) : False := by
  omega

theorem clause_16 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(355, true), (354, true)] := by
  refine if hc : Holds (assignment x) [(355, true), (354, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 11 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (355, true) ∈ [(355, true), (354, true)])))
    have g1 : ((x 11 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (354, true) ∈ [(355, true), (354, true)])))
    exact False.elim (arith_16 x (h.bound 11) h.diagonal g0 g1)

private theorem arith_17 (x : Fin 12 → Nat)
    (g0 : ((3 : Int)) ≠ (3 : Int)) (g1 : ((3 : Int)) = (3 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  omega

theorem clause_17 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2877, true), (57, false), (1, false)] := by
  refine if hc : Holds (assignment x) [(2877, true), (57, false), (1, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2877, true) ∈ [(2877, true), (57, false), (1, false)])))
    have g1 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (57, false) ∈ [(2877, true), (57, false), (1, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (1, false) ∈ [(2877, true), (57, false), (1, false)])))
    exact False.elim (arith_17 x g0 g1 g2)

private theorem arith_18 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int)) ≠ (3 : Int)) (g1 : ((x 1 : Int)) = (0 : Int)) (g2 : ((3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_18 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2882, true), (106, false), (2877, false)] := by
  refine if hc : Holds (assignment x) [(2882, true), (106, false), (2877, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2882, true) ∈ [(2882, true), (106, false), (2877, false)])))
    have g1 : ((x 1 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (106, false) ∈ [(2882, true), (106, false), (2877, false)])))
    have g2 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2877, false) ∈ [(2882, true), (106, false), (2877, false)])))
    exact False.elim (arith_18 x g0 g1 g2)

private theorem arith_19 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int)) ≠ (4 : Int)) (g1 : ((x 1 : Int)) = (1 : Int)) (g2 : ((3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_19 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2883, true), (107, false), (2877, false)] := by
  refine if hc : Holds (assignment x) [(2883, true), (107, false), (2877, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2883, true) ∈ [(2883, true), (107, false), (2877, false)])))
    have g1 : ((x 1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (107, false) ∈ [(2883, true), (107, false), (2877, false)])))
    have g2 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2877, false) ∈ [(2883, true), (107, false), (2877, false)])))
    exact False.elim (arith_19 x g0 g1 g2)

private theorem arith_20 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int)) ≠ (6 : Int)) (g1 : ((x 1 : Int)) = (3 : Int)) (g2 : ((3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_20 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2885, true), (109, false), (2877, false)] := by
  refine if hc : Holds (assignment x) [(2885, true), (109, false), (2877, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2885, true) ∈ [(2885, true), (109, false), (2877, false)])))
    have g1 : ((x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (109, false) ∈ [(2885, true), (109, false), (2877, false)])))
    have g2 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2877, false) ∈ [(2885, true), (109, false), (2877, false)])))
    exact False.elim (arith_20 x g0 g1 g2)

private theorem arith_21 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int)) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_21 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2882, false), (2885, false)] := by
  refine if hc : Holds (assignment x) [(2882, false), (2885, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2882, false) ∈ [(2882, false), (2885, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2885, false) ∈ [(2882, false), (2885, false)])))
    exact False.elim (arith_21 x g0 g1)

private theorem arith_22 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (3 : Int)) (g2 : ((x 2 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_22 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2891, true), (2882, false), (153, false)] := by
  refine if hc : Holds (assignment x) [(2891, true), (2882, false), (153, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2891, true) ∈ [(2891, true), (2882, false), (153, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2882, false) ∈ [(2891, true), (2882, false), (153, false)])))
    have g2 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(2891, true), (2882, false), (153, false)])))
    exact False.elim (arith_22 x g0 g1 g2)

private theorem arith_23 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int)) (g1 : ((x 2 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (4 : Int)) : False := by
  omega

theorem clause_23 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2894, true), (155, false), (2883, false)] := by
  refine if hc : Holds (assignment x) [(2894, true), (155, false), (2883, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2894, true) ∈ [(2894, true), (155, false), (2883, false)])))
    have g1 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (155, false) ∈ [(2894, true), (155, false), (2883, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2883, false) ∈ [(2894, true), (155, false), (2883, false)])))
    exact False.elim (arith_23 x g0 g1 g2)

private theorem arith_24 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_24 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2904, true), (2891, false), (195, false)] := by
  refine if hc : Holds (assignment x) [(2904, true), (2891, false), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2904, true) ∈ [(2904, true), (2891, false), (195, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2891, false) ∈ [(2904, true), (2891, false), (195, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(2904, true), (2891, false), (195, false)])))
    exact False.elim (arith_24 x g0 g1 g2)

private theorem arith_25 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_25 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2905, true), (2891, false), (196, false)] := by
  refine if hc : Holds (assignment x) [(2905, true), (2891, false), (196, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2905, true) ∈ [(2905, true), (2891, false), (196, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2891, false) ∈ [(2905, true), (2891, false), (196, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(2905, true), (2891, false), (196, false)])))
    exact False.elim (arith_25 x g0 g1 g2)

private theorem arith_26 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_26 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2906, true), (2891, false), (197, false)] := by
  refine if hc : Holds (assignment x) [(2906, true), (2891, false), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2906, true) ∈ [(2906, true), (2891, false), (197, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2891, false) ∈ [(2906, true), (2891, false), (197, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(2906, true), (2891, false), (197, false)])))
    exact False.elim (arith_26 x g0 g1 g2)

private theorem arith_27 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int)) (g2 : ((x 3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_27 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2907, true), (2891, false), (198, false)] := by
  refine if hc : Holds (assignment x) [(2907, true), (2891, false), (198, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2907, true) ∈ [(2907, true), (2891, false), (198, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2891, false) ∈ [(2907, true), (2891, false), (198, false)])))
    have g2 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (198, false) ∈ [(2907, true), (2891, false), (198, false)])))
    exact False.elim (arith_27 x g0 g1 g2)

private theorem arith_28 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_28 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2909, true), (2894, false), (197, false)] := by
  refine if hc : Holds (assignment x) [(2909, true), (2894, false), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2909, true) ∈ [(2909, true), (2894, false), (197, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2894, false) ∈ [(2909, true), (2894, false), (197, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(2909, true), (2894, false), (197, false)])))
    exact False.elim (arith_28 x g0 g1 g2)

private theorem arith_29 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_29 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2917, true), (2904, false), (232, false)] := by
  refine if hc : Holds (assignment x) [(2917, true), (2904, false), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2917, true) ∈ [(2917, true), (2904, false), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2904, false) ∈ [(2917, true), (2904, false), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(2917, true), (2904, false), (232, false)])))
    exact False.elim (arith_29 x g0 g1 g2)

private theorem arith_30 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_30 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2918, true), (2904, false), (233, false)] := by
  refine if hc : Holds (assignment x) [(2918, true), (2904, false), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2918, true) ∈ [(2918, true), (2904, false), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2904, false) ∈ [(2918, true), (2904, false), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(2918, true), (2904, false), (233, false)])))
    exact False.elim (arith_30 x g0 g1 g2)

private theorem arith_31 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int)) (g2 : ((x 4 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_31 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2919, true), (2904, false), (234, false)] := by
  refine if hc : Holds (assignment x) [(2919, true), (2904, false), (234, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2919, true) ∈ [(2919, true), (2904, false), (234, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2904, false) ∈ [(2919, true), (2904, false), (234, false)])))
    have g2 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(2919, true), (2904, false), (234, false)])))
    exact False.elim (arith_31 x g0 g1 g2)

private theorem arith_32 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int)) (g2 : ((x 4 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_32 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2920, true), (2904, false), (235, false)] := by
  refine if hc : Holds (assignment x) [(2920, true), (2904, false), (235, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2920, true) ∈ [(2920, true), (2904, false), (235, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2904, false) ∈ [(2920, true), (2904, false), (235, false)])))
    have g2 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (235, false) ∈ [(2920, true), (2904, false), (235, false)])))
    exact False.elim (arith_32 x g0 g1 g2)

private theorem arith_33 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (4 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_33 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2905, false), (2918, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(2905, false), (2918, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2905, false) ∈ [(2905, false), (2918, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2918, true) ∈ [(2905, false), (2918, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(2905, false), (2918, true), (232, false)])))
    exact False.elim (arith_33 x g0 g1 g2)

private theorem arith_34 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (4 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_34 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2919, true), (2905, false), (233, false)] := by
  refine if hc : Holds (assignment x) [(2919, true), (2905, false), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2919, true) ∈ [(2919, true), (2905, false), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2905, false) ∈ [(2919, true), (2905, false), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(2919, true), (2905, false), (233, false)])))
    exact False.elim (arith_34 x g0 g1 g2)

private theorem arith_35 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (4 : Int)) (g2 : ((x 4 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_35 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2920, true), (2905, false), (234, false)] := by
  refine if hc : Holds (assignment x) [(2920, true), (2905, false), (234, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2920, true) ∈ [(2920, true), (2905, false), (234, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2905, false) ∈ [(2920, true), (2905, false), (234, false)])))
    have g2 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(2920, true), (2905, false), (234, false)])))
    exact False.elim (arith_35 x g0 g1 g2)

private theorem arith_36 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (5 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_36 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2919, true), (2906, false), (232, false)] := by
  refine if hc : Holds (assignment x) [(2919, true), (2906, false), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2919, true) ∈ [(2919, true), (2906, false), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2906, false) ∈ [(2919, true), (2906, false), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(2919, true), (2906, false), (232, false)])))
    exact False.elim (arith_36 x g0 g1 g2)

private theorem arith_37 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (5 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_37 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2920, true), (2906, false), (233, false)] := by
  refine if hc : Holds (assignment x) [(2920, true), (2906, false), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2920, true) ∈ [(2920, true), (2906, false), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2906, false) ∈ [(2920, true), (2906, false), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(2920, true), (2906, false), (233, false)])))
    exact False.elim (arith_37 x g0 g1 g2)

private theorem arith_38 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_38 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2920, true), (2907, false), (232, false)] := by
  refine if hc : Holds (assignment x) [(2920, true), (2907, false), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2920, true) ∈ [(2920, true), (2907, false), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2907, false) ∈ [(2920, true), (2907, false), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(2920, true), (2907, false), (232, false)])))
    exact False.elim (arith_38 x g0 g1 g2)

private theorem arith_39 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (3 : Int)) (g2 : ((x 5 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_39 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2933, true), (2917, false), (267, false)] := by
  refine if hc : Holds (assignment x) [(2933, true), (2917, false), (267, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2933, true) ∈ [(2933, true), (2917, false), (267, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2917, false) ∈ [(2933, true), (2917, false), (267, false)])))
    have g2 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (267, false) ∈ [(2933, true), (2917, false), (267, false)])))
    exact False.elim (arith_39 x g0 g1 g2)

private theorem arith_40 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (6 : Int)) (g1 : ((x 5 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (4 : Int)) : False := by
  omega

theorem clause_40 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2933, true), (266, false), (2918, false)] := by
  refine if hc : Holds (assignment x) [(2933, true), (266, false), (2918, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2933, true) ∈ [(2933, true), (266, false), (2918, false)])))
    have g1 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (266, false) ∈ [(2933, true), (266, false), (2918, false)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2918, false) ∈ [(2933, true), (266, false), (2918, false)])))
    exact False.elim (arith_40 x g0 g1 g2)

private theorem arith_41 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (5 : Int)) (g2 : ((x 5 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_41 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2933, true), (2919, false), (265, false)] := by
  refine if hc : Holds (assignment x) [(2933, true), (2919, false), (265, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2933, true) ∈ [(2933, true), (2919, false), (265, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2919, false) ∈ [(2933, true), (2919, false), (265, false)])))
    have g2 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(2933, true), (2919, false), (265, false)])))
    exact False.elim (arith_41 x g0 g1 g2)

private theorem arith_42 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (6 : Int)) (g2 : ((x 5 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_42 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2933, true), (2920, false), (264, false)] := by
  refine if hc : Holds (assignment x) [(2933, true), (2920, false), (264, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2933, true) ∈ [(2933, true), (2920, false), (264, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2920, false) ∈ [(2933, true), (2920, false), (264, false)])))
    have g2 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(2933, true), (2920, false), (264, false)])))
    exact False.elim (arith_42 x g0 g1 g2)

private theorem arith_43 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int)) (g2 : ((x 6 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_43 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2946, true), (2933, false), (291, false)] := by
  refine if hc : Holds (assignment x) [(2946, true), (2933, false), (291, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2946, true) ∈ [(2946, true), (2933, false), (291, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2933, false) ∈ [(2946, true), (2933, false), (291, false)])))
    have g2 : ((x 6 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (291, false) ∈ [(2946, true), (2933, false), (291, false)])))
    exact False.elim (arith_43 x g0 g1 g2)

private theorem arith_44 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) ≠ (7 : Int)) (g1 : ((x 6 : Int)) = (1 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_44 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2947, true), (292, false), (2933, false)] := by
  refine if hc : Holds (assignment x) [(2947, true), (292, false), (2933, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2947, true) ∈ [(2947, true), (292, false), (2933, false)])))
    have g1 : ((x 6 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (292, false) ∈ [(2947, true), (292, false), (2933, false)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2933, false) ∈ [(2947, true), (292, false), (2933, false)])))
    exact False.elim (arith_44 x g0 g1 g2)

private theorem arith_45 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) ≠ (8 : Int)) (g1 : ((x 6 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_45 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2948, true), (293, false), (2933, false)] := by
  refine if hc : Holds (assignment x) [(2948, true), (293, false), (2933, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2948, true) ∈ [(2948, true), (293, false), (2933, false)])))
    have g1 : ((x 6 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (293, false) ∈ [(2948, true), (293, false), (2933, false)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2933, false) ∈ [(2948, true), (293, false), (2933, false)])))
    exact False.elim (arith_45 x g0 g1 g2)

private theorem arith_46 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) ≠ (9 : Int)) (g1 : ((x 6 : Int)) = (3 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_46 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2949, true), (294, false), (2933, false)] := by
  refine if hc : Holds (assignment x) [(2949, true), (294, false), (2933, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2949, true) ∈ [(2949, true), (294, false), (2933, false)])))
    have g1 : ((x 6 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (294, false) ∈ [(2949, true), (294, false), (2933, false)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2933, false) ∈ [(2949, true), (294, false), (2933, false)])))
    exact False.elim (arith_46 x g0 g1 g2)

private theorem arith_47 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (6 : Int)) (g2 : ((x 7 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_47 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2946, false), (2959, true), (313, false)] := by
  refine if hc : Holds (assignment x) [(2946, false), (2959, true), (313, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2946, false) ∈ [(2946, false), (2959, true), (313, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2959, true) ∈ [(2946, false), (2959, true), (313, false)])))
    have g2 : ((x 7 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (313, false) ∈ [(2946, false), (2959, true), (313, false)])))
    exact False.elim (arith_47 x g0 g1 g2)

private theorem arith_48 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (7 : Int)) (g2 : ((x 7 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_48 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2946, false), (2960, true), (314, false)] := by
  refine if hc : Holds (assignment x) [(2946, false), (2960, true), (314, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2946, false) ∈ [(2946, false), (2960, true), (314, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2960, true) ∈ [(2946, false), (2960, true), (314, false)])))
    have g2 : ((x 7 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (314, false) ∈ [(2946, false), (2960, true), (314, false)])))
    exact False.elim (arith_48 x g0 g1 g2)

private theorem arith_49 (x : Fin 12 → Nat)
    (g0 : ((x 7 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (8 : Int)) : False := by
  omega

theorem clause_49 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(315, false), (2946, false), (2961, true)] := by
  refine if hc : Holds (assignment x) [(315, false), (2946, false), (2961, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (315, false) ∈ [(315, false), (2946, false), (2961, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2946, false) ∈ [(315, false), (2946, false), (2961, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2961, true) ∈ [(315, false), (2946, false), (2961, true)])))
    exact False.elim (arith_49 x g0 g1 g2)

private theorem arith_50 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int)) (g1 : ((x 7 : Int)) = (3 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_50 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2946, false), (316, false), (2962, true)] := by
  refine if hc : Holds (assignment x) [(2946, false), (316, false), (2962, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2946, false) ∈ [(2946, false), (316, false), (2962, true)])))
    have g1 : ((x 7 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (316, false) ∈ [(2946, false), (316, false), (2962, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2962, true) ∈ [(2946, false), (316, false), (2962, true)])))
    exact False.elim (arith_50 x g0 g1 g2)

private theorem arith_51 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int)) (g1 : ((x 7 : Int)) = (4 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_51 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2946, false), (317, false), (2963, true)] := by
  refine if hc : Holds (assignment x) [(2946, false), (317, false), (2963, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2946, false) ∈ [(2946, false), (317, false), (2963, true)])))
    have g1 : ((x 7 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (317, false) ∈ [(2946, false), (317, false), (2963, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2963, true) ∈ [(2946, false), (317, false), (2963, true)])))
    exact False.elim (arith_51 x g0 g1 g2)

private theorem arith_52 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (7 : Int)) (g2 : ((x 7 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_52 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2947, false), (2960, true), (313, false)] := by
  refine if hc : Holds (assignment x) [(2947, false), (2960, true), (313, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2947, false) ∈ [(2947, false), (2960, true), (313, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2960, true) ∈ [(2947, false), (2960, true), (313, false)])))
    have g2 : ((x 7 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (313, false) ∈ [(2947, false), (2960, true), (313, false)])))
    exact False.elim (arith_52 x g0 g1 g2)

private theorem arith_53 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (8 : Int)) (g2 : ((x 7 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_53 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2947, false), (2961, true), (314, false)] := by
  refine if hc : Holds (assignment x) [(2947, false), (2961, true), (314, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2947, false) ∈ [(2947, false), (2961, true), (314, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2961, true) ∈ [(2947, false), (2961, true), (314, false)])))
    have g2 : ((x 7 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (314, false) ∈ [(2947, false), (2961, true), (314, false)])))
    exact False.elim (arith_53 x g0 g1 g2)

private theorem arith_54 (x : Fin 12 → Nat)
    (g0 : ((x 7 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_54 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(315, false), (2947, false), (2962, true)] := by
  refine if hc : Holds (assignment x) [(315, false), (2947, false), (2962, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (315, false) ∈ [(315, false), (2947, false), (2962, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2947, false) ∈ [(315, false), (2947, false), (2962, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2962, true) ∈ [(315, false), (2947, false), (2962, true)])))
    exact False.elim (arith_54 x g0 g1 g2)

private theorem arith_55 (x : Fin 12 → Nat)
    (g0 : ((x 7 : Int)) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_55 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(316, false), (2947, false), (2963, true)] := by
  refine if hc : Holds (assignment x) [(316, false), (2947, false), (2963, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (316, false) ∈ [(316, false), (2947, false), (2963, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2947, false) ∈ [(316, false), (2947, false), (2963, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2963, true) ∈ [(316, false), (2947, false), (2963, true)])))
    exact False.elim (arith_55 x g0 g1 g2)

private theorem arith_56 (x : Fin 12 → Nat)
    (g0 : ((x 7 : Int)) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (11 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int)) : False := by
  omega

theorem clause_56 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(317, false), (2964, true), (2947, false)] := by
  refine if hc : Holds (assignment x) [(317, false), (2964, true), (2947, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (317, false) ∈ [(317, false), (2964, true), (2947, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2964, true) ∈ [(317, false), (2964, true), (2947, false)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2947, false) ∈ [(317, false), (2964, true), (2947, false)])))
    exact False.elim (arith_56 x g0 g1 g2)

private theorem arith_57 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (8 : Int)) (g2 : ((x 7 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_57 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2948, false), (2961, true), (313, false)] := by
  refine if hc : Holds (assignment x) [(2948, false), (2961, true), (313, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2948, false) ∈ [(2948, false), (2961, true), (313, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2961, true) ∈ [(2948, false), (2961, true), (313, false)])))
    have g2 : ((x 7 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (313, false) ∈ [(2948, false), (2961, true), (313, false)])))
    exact False.elim (arith_57 x g0 g1 g2)

private theorem arith_58 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (9 : Int)) (g2 : ((x 7 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_58 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2948, false), (2962, true), (314, false)] := by
  refine if hc : Holds (assignment x) [(2948, false), (2962, true), (314, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2948, false) ∈ [(2948, false), (2962, true), (314, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2962, true) ∈ [(2948, false), (2962, true), (314, false)])))
    have g2 : ((x 7 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (314, false) ∈ [(2948, false), (2962, true), (314, false)])))
    exact False.elim (arith_58 x g0 g1 g2)

private theorem arith_59 (x : Fin 12 → Nat)
    (g0 : ((x 7 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_59 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(315, false), (2948, false), (2963, true)] := by
  refine if hc : Holds (assignment x) [(315, false), (2948, false), (2963, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (315, false) ∈ [(315, false), (2948, false), (2963, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2948, false) ∈ [(315, false), (2948, false), (2963, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2963, true) ∈ [(315, false), (2948, false), (2963, true)])))
    exact False.elim (arith_59 x g0 g1 g2)

private theorem arith_60 (x : Fin 12 → Nat)
    (g0 : ((x 7 : Int)) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_60 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(316, false), (2948, false), (2964, true)] := by
  refine if hc : Holds (assignment x) [(316, false), (2948, false), (2964, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (316, false) ∈ [(316, false), (2948, false), (2964, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2948, false) ∈ [(316, false), (2948, false), (2964, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2964, true) ∈ [(316, false), (2948, false), (2964, true)])))
    exact False.elim (arith_60 x g0 g1 g2)

private theorem arith_61 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (9 : Int)) (g2 : ((x 7 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_61 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2949, false), (2962, true), (313, false)] := by
  refine if hc : Holds (assignment x) [(2949, false), (2962, true), (313, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2949, false) ∈ [(2949, false), (2962, true), (313, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2962, true) ∈ [(2949, false), (2962, true), (313, false)])))
    have g2 : ((x 7 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (313, false) ∈ [(2949, false), (2962, true), (313, false)])))
    exact False.elim (arith_61 x g0 g1 g2)

private theorem arith_62 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (10 : Int)) (g2 : ((x 7 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_62 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2949, false), (2963, true), (314, false)] := by
  refine if hc : Holds (assignment x) [(2949, false), (2963, true), (314, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2949, false) ∈ [(2949, false), (2963, true), (314, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2963, true) ∈ [(2949, false), (2963, true), (314, false)])))
    have g2 : ((x 7 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (314, false) ∈ [(2949, false), (2963, true), (314, false)])))
    exact False.elim (arith_62 x g0 g1 g2)

private theorem arith_63 (x : Fin 12 → Nat)
    (g0 : ((x 7 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_63 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(315, false), (2949, false), (2964, true)] := by
  refine if hc : Holds (assignment x) [(315, false), (2949, false), (2964, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (315, false) ∈ [(315, false), (2949, false), (2964, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2949, false) ∈ [(315, false), (2949, false), (2964, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2964, true) ∈ [(315, false), (2949, false), (2964, true)])))
    exact False.elim (arith_63 x g0 g1 g2)

private theorem arith_64 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0+x 1+x 2+x 3+x 4+x 5+x 6+x 7+x 8+x 9+x 10+x 11 = 12) (g0 : ((x 7 : Int)) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_64 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(317, false), (2949, false)] := by
  refine if hc : Holds (assignment x) [(317, false), (2949, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (317, false) ∈ [(317, false), (2949, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2949, false) ∈ [(317, false), (2949, false)])))
    exact False.elim (arith_64 x h.zero h.total g0 g1)

private theorem arith_65 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (6 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (6 : Int)) : False := by
  omega

theorem clause_65 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2959, false), (330, false), (2972, true)] := by
  refine if hc : Holds (assignment x) [(2959, false), (330, false), (2972, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2959, false) ∈ [(2959, false), (330, false), (2972, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (330, false) ∈ [(2959, false), (330, false), (2972, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2972, true) ∈ [(2959, false), (330, false), (2972, true)])))
    exact False.elim (arith_65 x g0 g1 g2)

private theorem arith_66 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (7 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (7 : Int)) : False := by
  omega

theorem clause_66 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2960, false), (330, false), (2973, true)] := by
  refine if hc : Holds (assignment x) [(2960, false), (330, false), (2973, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2960, false) ∈ [(2960, false), (330, false), (2973, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (330, false) ∈ [(2960, false), (330, false), (2973, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2973, true) ∈ [(2960, false), (330, false), (2973, true)])))
    exact False.elim (arith_66 x g0 g1 g2)

private theorem arith_67 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (8 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (8 : Int)) : False := by
  omega

theorem clause_67 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2961, false), (330, false), (2974, true)] := by
  refine if hc : Holds (assignment x) [(2961, false), (330, false), (2974, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2961, false) ∈ [(2961, false), (330, false), (2974, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (330, false) ∈ [(2961, false), (330, false), (2974, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2974, true) ∈ [(2961, false), (330, false), (2974, true)])))
    exact False.elim (arith_67 x g0 g1 g2)

private theorem arith_68 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (9 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_68 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2962, false), (330, false), (2975, true)] := by
  refine if hc : Holds (assignment x) [(2962, false), (330, false), (2975, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2962, false) ∈ [(2962, false), (330, false), (2975, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (330, false) ∈ [(2962, false), (330, false), (2975, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2975, true) ∈ [(2962, false), (330, false), (2975, true)])))
    exact False.elim (arith_68 x g0 g1 g2)

private theorem arith_69 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (10 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_69 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2963, false), (330, false), (2976, true)] := by
  refine if hc : Holds (assignment x) [(2963, false), (330, false), (2976, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2963, false) ∈ [(2963, false), (330, false), (2976, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (330, false) ∈ [(2963, false), (330, false), (2976, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2976, true) ∈ [(2963, false), (330, false), (2976, true)])))
    exact False.elim (arith_69 x g0 g1 g2)

private theorem arith_70 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (11 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_70 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2964, false), (330, false), (2977, true)] := by
  refine if hc : Holds (assignment x) [(2964, false), (330, false), (2977, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2964, false) ∈ [(2964, false), (330, false), (2977, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (330, false) ∈ [(2964, false), (330, false), (2977, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2977, true) ∈ [(2964, false), (330, false), (2977, true)])))
    exact False.elim (arith_70 x g0 g1 g2)

private theorem arith_71 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (6 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (6 : Int)) : False := by
  omega

theorem clause_71 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2972, false), (342, false), (2985, true)] := by
  refine if hc : Holds (assignment x) [(2972, false), (342, false), (2985, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2972, false) ∈ [(2972, false), (342, false), (2985, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (342, false) ∈ [(2972, false), (342, false), (2985, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2985, true) ∈ [(2972, false), (342, false), (2985, true)])))
    exact False.elim (arith_71 x g0 g1 g2)

private theorem arith_72 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (7 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (7 : Int)) : False := by
  omega

theorem clause_72 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2973, false), (342, false), (2986, true)] := by
  refine if hc : Holds (assignment x) [(2973, false), (342, false), (2986, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2973, false) ∈ [(2973, false), (342, false), (2986, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (342, false) ∈ [(2973, false), (342, false), (2986, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2986, true) ∈ [(2973, false), (342, false), (2986, true)])))
    exact False.elim (arith_72 x g0 g1 g2)

private theorem arith_73 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (8 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (8 : Int)) : False := by
  omega

theorem clause_73 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2974, false), (342, false), (2987, true)] := by
  refine if hc : Holds (assignment x) [(2974, false), (342, false), (2987, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2974, false) ∈ [(2974, false), (342, false), (2987, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (342, false) ∈ [(2974, false), (342, false), (2987, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2987, true) ∈ [(2974, false), (342, false), (2987, true)])))
    exact False.elim (arith_73 x g0 g1 g2)

private theorem arith_74 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (9 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_74 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2975, false), (342, false), (2988, true)] := by
  refine if hc : Holds (assignment x) [(2975, false), (342, false), (2988, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2975, false) ∈ [(2975, false), (342, false), (2988, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (342, false) ∈ [(2975, false), (342, false), (2988, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2988, true) ∈ [(2975, false), (342, false), (2988, true)])))
    exact False.elim (arith_74 x g0 g1 g2)

private theorem arith_75 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (10 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_75 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2976, false), (342, false), (2989, true)] := by
  refine if hc : Holds (assignment x) [(2976, false), (342, false), (2989, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2976, false) ∈ [(2976, false), (342, false), (2989, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (342, false) ∈ [(2976, false), (342, false), (2989, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2989, true) ∈ [(2976, false), (342, false), (2989, true)])))
    exact False.elim (arith_75 x g0 g1 g2)

private theorem arith_76 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (11 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_76 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2977, false), (342, false), (2990, true)] := by
  refine if hc : Holds (assignment x) [(2977, false), (342, false), (2990, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2977, false) ∈ [(2977, false), (342, false), (2990, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (342, false) ∈ [(2977, false), (342, false), (2990, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2990, true) ∈ [(2977, false), (342, false), (2990, true)])))
    exact False.elim (arith_76 x g0 g1 g2)

private theorem arith_77 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (0 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (6 : Int)) : False := by
  omega

theorem clause_77 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(349, false), (2985, false), (2998, true)] := by
  refine if hc : Holds (assignment x) [(349, false), (2985, false), (2998, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (349, false) ∈ [(349, false), (2985, false), (2998, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2985, false) ∈ [(349, false), (2985, false), (2998, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2998, true) ∈ [(349, false), (2985, false), (2998, true)])))
    exact False.elim (arith_77 x g0 g1 g2)

private theorem arith_78 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (7 : Int)) : False := by
  omega

theorem clause_78 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(350, false), (2985, false), (2999, true)] := by
  refine if hc : Holds (assignment x) [(350, false), (2985, false), (2999, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (350, false) ∈ [(350, false), (2985, false), (2999, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2985, false) ∈ [(350, false), (2985, false), (2999, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2999, true) ∈ [(350, false), (2985, false), (2999, true)])))
    exact False.elim (arith_78 x g0 g1 g2)

private theorem arith_79 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (8 : Int)) : False := by
  omega

theorem clause_79 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(351, false), (2985, false), (3000, true)] := by
  refine if hc : Holds (assignment x) [(351, false), (2985, false), (3000, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (351, false) ∈ [(351, false), (2985, false), (3000, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2985, false) ∈ [(351, false), (2985, false), (3000, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3000, true) ∈ [(351, false), (2985, false), (3000, true)])))
    exact False.elim (arith_79 x g0 g1 g2)

private theorem arith_80 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_80 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(352, false), (2985, false), (3001, true)] := by
  refine if hc : Holds (assignment x) [(352, false), (2985, false), (3001, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (352, false) ∈ [(352, false), (2985, false), (3001, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2985, false) ∈ [(352, false), (2985, false), (3001, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3001, true) ∈ [(352, false), (2985, false), (3001, true)])))
    exact False.elim (arith_80 x g0 g1 g2)

private theorem arith_81 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (7 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (7 : Int)) : False := by
  omega

theorem clause_81 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2986, false), (349, false), (2999, true)] := by
  refine if hc : Holds (assignment x) [(2986, false), (349, false), (2999, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2986, false) ∈ [(2986, false), (349, false), (2999, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (349, false) ∈ [(2986, false), (349, false), (2999, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (2999, true) ∈ [(2986, false), (349, false), (2999, true)])))
    exact False.elim (arith_81 x g0 g1 g2)

private theorem arith_82 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (8 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (8 : Int)) : False := by
  omega

theorem clause_82 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2987, false), (349, false), (3000, true)] := by
  refine if hc : Holds (assignment x) [(2987, false), (349, false), (3000, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2987, false) ∈ [(2987, false), (349, false), (3000, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (349, false) ∈ [(2987, false), (349, false), (3000, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3000, true) ∈ [(2987, false), (349, false), (3000, true)])))
    exact False.elim (arith_82 x g0 g1 g2)

private theorem arith_83 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_83 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2988, false), (349, false), (3001, true)] := by
  refine if hc : Holds (assignment x) [(2988, false), (349, false), (3001, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2988, false) ∈ [(2988, false), (349, false), (3001, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (349, false) ∈ [(2988, false), (349, false), (3001, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3001, true) ∈ [(2988, false), (349, false), (3001, true)])))
    exact False.elim (arith_83 x g0 g1 g2)

private theorem arith_84 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_84 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(350, false), (2988, false), (3002, true)] := by
  refine if hc : Holds (assignment x) [(350, false), (2988, false), (3002, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (350, false) ∈ [(350, false), (2988, false), (3002, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2988, false) ∈ [(350, false), (2988, false), (3002, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3002, true) ∈ [(350, false), (2988, false), (3002, true)])))
    exact False.elim (arith_84 x g0 g1 g2)

private theorem arith_85 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0+x 1+x 2+x 3+x 4+x 5+x 6+x 7+x 8+x 9+x 10+x 11 = 12) (g0 : ((x 10 : Int)) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_85 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(353, false), (2988, false)] := by
  refine if hc : Holds (assignment x) [(353, false), (2988, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (353, false) ∈ [(353, false), (2988, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2988, false) ∈ [(353, false), (2988, false)])))
    exact False.elim (arith_85 x h.zero h.total g0 g1)

private theorem arith_86 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_86 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2989, false), (349, false), (3002, true)] := by
  refine if hc : Holds (assignment x) [(2989, false), (349, false), (3002, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2989, false) ∈ [(2989, false), (349, false), (3002, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (349, false) ∈ [(2989, false), (349, false), (3002, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3002, true) ∈ [(2989, false), (349, false), (3002, true)])))
    exact False.elim (arith_86 x g0 g1 g2)

private theorem arith_87 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_87 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2990, false), (349, false), (3003, true)] := by
  refine if hc : Holds (assignment x) [(2990, false), (349, false), (3003, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2990, false) ∈ [(2990, false), (349, false), (3003, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (349, false) ∈ [(2990, false), (349, false), (3003, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3003, true) ∈ [(2990, false), (349, false), (3003, true)])))
    exact False.elim (arith_87 x g0 g1 g2)

private theorem arith_88 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (6 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (6 : Int)) : False := by
  omega

theorem clause_88 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2998, false), (354, false), (3011, true)] := by
  refine if hc : Holds (assignment x) [(2998, false), (354, false), (3011, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2998, false) ∈ [(2998, false), (354, false), (3011, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(2998, false), (354, false), (3011, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3011, true) ∈ [(2998, false), (354, false), (3011, true)])))
    exact False.elim (arith_88 x g0 g1 g2)

private theorem arith_89 (x : Fin 12 → Nat)
    (g0 : ((x 11 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (6 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (8 : Int)) : False := by
  omega

theorem clause_89 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(355, false), (2998, false), (3013, true)] := by
  refine if hc : Holds (assignment x) [(355, false), (2998, false), (3013, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 11 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (355, false) ∈ [(355, false), (2998, false), (3013, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2998, false) ∈ [(355, false), (2998, false), (3013, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3013, true) ∈ [(355, false), (2998, false), (3013, true)])))
    exact False.elim (arith_89 x g0 g1 g2)

private theorem arith_90 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (7 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (7 : Int)) : False := by
  omega

theorem clause_90 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2999, false), (354, false), (3012, true)] := by
  refine if hc : Holds (assignment x) [(2999, false), (354, false), (3012, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2999, false) ∈ [(2999, false), (354, false), (3012, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(2999, false), (354, false), (3012, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3012, true) ∈ [(2999, false), (354, false), (3012, true)])))
    exact False.elim (arith_90 x g0 g1 g2)

private theorem arith_91 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (7 : Int)) (g1 : ((x 11 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_91 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(2999, false), (355, false), (3014, true)] := by
  refine if hc : Holds (assignment x) [(2999, false), (355, false), (3014, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (2999, false) ∈ [(2999, false), (355, false), (3014, true)])))
    have g1 : ((x 11 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (355, false) ∈ [(2999, false), (355, false), (3014, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3014, true) ∈ [(2999, false), (355, false), (3014, true)])))
    exact False.elim (arith_91 x g0 g1 g2)

private theorem arith_92 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (8 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (8 : Int)) : False := by
  omega

theorem clause_92 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3000, false), (354, false), (3013, true)] := by
  refine if hc : Holds (assignment x) [(3000, false), (354, false), (3013, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3000, false) ∈ [(3000, false), (354, false), (3013, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(3000, false), (354, false), (3013, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3013, true) ∈ [(3000, false), (354, false), (3013, true)])))
    exact False.elim (arith_92 x g0 g1 g2)

private theorem arith_93 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (8 : Int)) (g1 : ((x 11 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_93 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3000, false), (355, false), (3015, true)] := by
  refine if hc : Holds (assignment x) [(3000, false), (355, false), (3015, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3000, false) ∈ [(3000, false), (355, false), (3015, true)])))
    have g1 : ((x 11 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (355, false) ∈ [(3000, false), (355, false), (3015, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3015, true) ∈ [(3000, false), (355, false), (3015, true)])))
    exact False.elim (arith_93 x g0 g1 g2)

private theorem arith_94 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (9 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_94 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3001, false), (354, false), (3014, true)] := by
  refine if hc : Holds (assignment x) [(3001, false), (354, false), (3014, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3001, false) ∈ [(3001, false), (354, false), (3014, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(3001, false), (354, false), (3014, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3014, true) ∈ [(3001, false), (354, false), (3014, true)])))
    exact False.elim (arith_94 x g0 g1 g2)

private theorem arith_95 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (9 : Int)) (g1 : ((x 11 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_95 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3001, false), (355, false), (3016, true)] := by
  refine if hc : Holds (assignment x) [(3001, false), (355, false), (3016, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3001, false) ∈ [(3001, false), (355, false), (3016, true)])))
    have g1 : ((x 11 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (355, false) ∈ [(3001, false), (355, false), (3016, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3016, true) ∈ [(3001, false), (355, false), (3016, true)])))
    exact False.elim (arith_95 x g0 g1 g2)

private theorem arith_96 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_96 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3002, false), (354, false), (3015, true)] := by
  refine if hc : Holds (assignment x) [(3002, false), (354, false), (3015, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3002, false) ∈ [(3002, false), (354, false), (3015, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(3002, false), (354, false), (3015, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3015, true) ∈ [(3002, false), (354, false), (3015, true)])))
    exact False.elim (arith_96 x g0 g1 g2)

private theorem arith_97 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_97 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3003, false), (354, false), (3016, true)] := by
  refine if hc : Holds (assignment x) [(3003, false), (354, false), (3016, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3003, false) ∈ [(3003, false), (354, false), (3016, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(3003, false), (354, false), (3016, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3016, true) ∈ [(3003, false), (354, false), (3016, true)])))
    exact False.elim (arith_97 x g0 g1 g2)

private theorem arith_98 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_98 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3011, false), (3017, false)] := by
  refine if hc : Holds (assignment x) [(3011, false), (3017, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3011, false) ∈ [(3011, false), (3017, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3017, false) ∈ [(3011, false), (3017, false)])))
    exact False.elim (arith_98 x g0 g1)

private theorem arith_99 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_99 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3012, false), (3017, false)] := by
  refine if hc : Holds (assignment x) [(3012, false), (3017, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3012, false) ∈ [(3012, false), (3017, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3017, false) ∈ [(3012, false), (3017, false)])))
    exact False.elim (arith_99 x g0 g1)

private theorem arith_100 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_100 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3013, false), (3017, false)] := by
  refine if hc : Holds (assignment x) [(3013, false), (3017, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3013, false) ∈ [(3013, false), (3017, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3017, false) ∈ [(3013, false), (3017, false)])))
    exact False.elim (arith_100 x g0 g1)

private theorem arith_101 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (9 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_101 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3014, false), (3017, false)] := by
  refine if hc : Holds (assignment x) [(3014, false), (3017, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3014, false) ∈ [(3014, false), (3017, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3017, false) ∈ [(3014, false), (3017, false)])))
    exact False.elim (arith_101 x g0 g1)

private theorem arith_102 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (10 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_102 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3015, false), (3017, false)] := by
  refine if hc : Holds (assignment x) [(3015, false), (3017, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3015, false) ∈ [(3015, false), (3017, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3017, false) ∈ [(3015, false), (3017, false)])))
    exact False.elim (arith_102 x g0 g1)

private theorem arith_103 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (11 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_103 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3016, false), (3017, false)] := by
  refine if hc : Holds (assignment x) [(3016, false), (3017, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3016, false) ∈ [(3016, false), (3017, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3017, false) ∈ [(3016, false), (3017, false)])))
    exact False.elim (arith_103 x g0 g1)

private theorem arith_104 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0+x 1+x 2+x 3+x 4+x 5+x 6+x 7+x 8+x 9+x 10+x 11 = 12) (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_104 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3017, true)] := by
  refine if hc : Holds (assignment x) [(3017, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 6 : Int) + (x 7 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (x 11 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3017, true) ∈ [(3017, true)])))
    exact False.elim (arith_104 x h.zero h.total g0)

private theorem arith_105 (x : Fin 12 → Nat)
    (g0 : ((3 : Int)) ≠ (3 : Int)) (g1 : ((3 : Int)) = (3 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  omega

theorem clause_105 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3021, true), (57, false), (1, false)] := by
  refine if hc : Holds (assignment x) [(3021, true), (57, false), (1, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3021, true) ∈ [(3021, true), (57, false), (1, false)])))
    have g1 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (57, false) ∈ [(3021, true), (57, false), (1, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (1, false) ∈ [(3021, true), (57, false), (1, false)])))
    exact False.elim (arith_105 x g0 g1 g2)

private theorem arith_106 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int)) ≠ (3 : Int)) (g1 : ((x 1 : Int)) = (0 : Int)) (g2 : ((3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_106 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3026, true), (106, false), (3021, false)] := by
  refine if hc : Holds (assignment x) [(3026, true), (106, false), (3021, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3026, true) ∈ [(3026, true), (106, false), (3021, false)])))
    have g1 : ((x 1 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (106, false) ∈ [(3026, true), (106, false), (3021, false)])))
    have g2 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3021, false) ∈ [(3026, true), (106, false), (3021, false)])))
    exact False.elim (arith_106 x g0 g1 g2)

private theorem arith_107 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int)) ≠ (4 : Int)) (g1 : ((x 1 : Int)) = (1 : Int)) (g2 : ((3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_107 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3027, true), (107, false), (3021, false)] := by
  refine if hc : Holds (assignment x) [(3027, true), (107, false), (3021, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3027, true) ∈ [(3027, true), (107, false), (3021, false)])))
    have g1 : ((x 1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (107, false) ∈ [(3027, true), (107, false), (3021, false)])))
    have g2 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3021, false) ∈ [(3027, true), (107, false), (3021, false)])))
    exact False.elim (arith_107 x g0 g1 g2)

private theorem arith_108 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int)) ≠ (5 : Int)) (g1 : ((x 1 : Int)) = (2 : Int)) (g2 : ((3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_108 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3028, true), (108, false), (3021, false)] := by
  refine if hc : Holds (assignment x) [(3028, true), (108, false), (3021, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int)) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3028, true) ∈ [(3028, true), (108, false), (3021, false)])))
    have g1 : ((x 1 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (108, false) ∈ [(3028, true), (108, false), (3021, false)])))
    have g2 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3021, false) ∈ [(3028, true), (108, false), (3021, false)])))
    exact False.elim (arith_108 x g0 g1 g2)

private theorem arith_109 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int)) ≠ (6 : Int)) (g1 : ((x 1 : Int)) = (3 : Int)) (g2 : ((3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_109 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3029, true), (109, false), (3021, false)] := by
  refine if hc : Holds (assignment x) [(3029, true), (109, false), (3021, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3029, true) ∈ [(3029, true), (109, false), (3021, false)])))
    have g1 : ((x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (109, false) ∈ [(3029, true), (109, false), (3021, false)])))
    have g2 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3021, false) ∈ [(3029, true), (109, false), (3021, false)])))
    exact False.elim (arith_109 x g0 g1 g2)

private theorem arith_110 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (3 : Int)) (g2 : ((x 2 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_110 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3035, true), (3026, false), (153, false)] := by
  refine if hc : Holds (assignment x) [(3035, true), (3026, false), (153, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3035, true) ∈ [(3035, true), (3026, false), (153, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3026, false) ∈ [(3035, true), (3026, false), (153, false)])))
    have g2 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(3035, true), (3026, false), (153, false)])))
    exact False.elim (arith_110 x g0 g1 g2)

private theorem arith_111 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (4 : Int)) (g1 : ((x 2 : Int)) = (1 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_111 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3036, true), (154, false), (3026, false)] := by
  refine if hc : Holds (assignment x) [(3036, true), (154, false), (3026, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3036, true) ∈ [(3036, true), (154, false), (3026, false)])))
    have g1 : ((x 2 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (154, false) ∈ [(3036, true), (154, false), (3026, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3026, false) ∈ [(3036, true), (154, false), (3026, false)])))
    exact False.elim (arith_111 x g0 g1 g2)

private theorem arith_112 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (3 : Int)) (g2 : ((x 2 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_112 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3037, true), (3026, false), (155, false)] := by
  refine if hc : Holds (assignment x) [(3037, true), (3026, false), (155, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3037, true) ∈ [(3037, true), (3026, false), (155, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3026, false) ∈ [(3037, true), (3026, false), (155, false)])))
    have g2 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (155, false) ∈ [(3037, true), (3026, false), (155, false)])))
    exact False.elim (arith_112 x g0 g1 g2)

private theorem arith_113 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (3 : Int)) (g2 : ((x 2 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_113 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3038, true), (3026, false), (156, false)] := by
  refine if hc : Holds (assignment x) [(3038, true), (3026, false), (156, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3038, true) ∈ [(3038, true), (3026, false), (156, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3026, false) ∈ [(3038, true), (3026, false), (156, false)])))
    have g2 : ((x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (156, false) ∈ [(3038, true), (3026, false), (156, false)])))
    exact False.elim (arith_113 x g0 g1 g2)

private theorem arith_114 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (4 : Int)) (g2 : ((x 2 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_114 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3036, true), (3027, false), (153, false)] := by
  refine if hc : Holds (assignment x) [(3036, true), (3027, false), (153, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3036, true) ∈ [(3036, true), (3027, false), (153, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3027, false) ∈ [(3036, true), (3027, false), (153, false)])))
    have g2 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(3036, true), (3027, false), (153, false)])))
    exact False.elim (arith_114 x g0 g1 g2)

private theorem arith_115 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (5 : Int)) (g1 : ((x 2 : Int)) = (1 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (4 : Int)) : False := by
  omega

theorem clause_115 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3037, true), (154, false), (3027, false)] := by
  refine if hc : Holds (assignment x) [(3037, true), (154, false), (3027, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3037, true) ∈ [(3037, true), (154, false), (3027, false)])))
    have g1 : ((x 2 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (154, false) ∈ [(3037, true), (154, false), (3027, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3027, false) ∈ [(3037, true), (154, false), (3027, false)])))
    exact False.elim (arith_115 x g0 g1 g2)

private theorem arith_116 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int)) (g1 : ((x 2 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (4 : Int)) : False := by
  omega

theorem clause_116 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3038, true), (155, false), (3027, false)] := by
  refine if hc : Holds (assignment x) [(3038, true), (155, false), (3027, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3038, true) ∈ [(3038, true), (155, false), (3027, false)])))
    have g1 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (155, false) ∈ [(3038, true), (155, false), (3027, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3027, false) ∈ [(3038, true), (155, false), (3027, false)])))
    exact False.elim (arith_116 x g0 g1 g2)

private theorem arith_117 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (4 : Int)) (g2 : ((x 2 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_117 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3039, true), (3027, false), (156, false)] := by
  refine if hc : Holds (assignment x) [(3039, true), (3027, false), (156, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3039, true) ∈ [(3039, true), (3027, false), (156, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3027, false) ∈ [(3039, true), (3027, false), (156, false)])))
    have g2 : ((x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (156, false) ∈ [(3039, true), (3027, false), (156, false)])))
    exact False.elim (arith_117 x g0 g1 g2)

private theorem arith_118 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (5 : Int)) (g2 : ((x 2 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_118 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3037, true), (3028, false), (153, false)] := by
  refine if hc : Holds (assignment x) [(3037, true), (3028, false), (153, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3037, true) ∈ [(3037, true), (3028, false), (153, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3028, false) ∈ [(3037, true), (3028, false), (153, false)])))
    have g2 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(3037, true), (3028, false), (153, false)])))
    exact False.elim (arith_118 x g0 g1 g2)

private theorem arith_119 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int)) (g1 : ((x 2 : Int)) = (1 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (5 : Int)) : False := by
  omega

theorem clause_119 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3038, true), (154, false), (3028, false)] := by
  refine if hc : Holds (assignment x) [(3038, true), (154, false), (3028, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3038, true) ∈ [(3038, true), (154, false), (3028, false)])))
    have g1 : ((x 2 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (154, false) ∈ [(3038, true), (154, false), (3028, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3028, false) ∈ [(3038, true), (154, false), (3028, false)])))
    exact False.elim (arith_119 x g0 g1 g2)

private theorem arith_120 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (7 : Int)) (g1 : ((x 2 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (5 : Int)) : False := by
  omega

theorem clause_120 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3039, true), (155, false), (3028, false)] := by
  refine if hc : Holds (assignment x) [(3039, true), (155, false), (3028, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3039, true) ∈ [(3039, true), (155, false), (3028, false)])))
    have g1 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (155, false) ∈ [(3039, true), (155, false), (3028, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3028, false) ∈ [(3039, true), (155, false), (3028, false)])))
    exact False.elim (arith_120 x g0 g1 g2)

private theorem arith_121 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (8 : Int)) (g1 : ((x 2 : Int)) = (3 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (5 : Int)) : False := by
  omega

theorem clause_121 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3040, true), (156, false), (3028, false)] := by
  refine if hc : Holds (assignment x) [(3040, true), (156, false), (3028, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3040, true) ∈ [(3040, true), (156, false), (3028, false)])))
    have g1 : ((x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (156, false) ∈ [(3040, true), (156, false), (3028, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3028, false) ∈ [(3040, true), (156, false), (3028, false)])))
    exact False.elim (arith_121 x g0 g1 g2)

private theorem arith_122 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (6 : Int)) (g2 : ((x 2 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_122 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3038, true), (3029, false), (153, false)] := by
  refine if hc : Holds (assignment x) [(3038, true), (3029, false), (153, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3038, true) ∈ [(3038, true), (3029, false), (153, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3029, false) ∈ [(3038, true), (3029, false), (153, false)])))
    have g2 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(3038, true), (3029, false), (153, false)])))
    exact False.elim (arith_122 x g0 g1 g2)

private theorem arith_123 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (7 : Int)) (g1 : ((x 2 : Int)) = (1 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_123 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3039, true), (154, false), (3029, false)] := by
  refine if hc : Holds (assignment x) [(3039, true), (154, false), (3029, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3039, true) ∈ [(3039, true), (154, false), (3029, false)])))
    have g1 : ((x 2 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (154, false) ∈ [(3039, true), (154, false), (3029, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3029, false) ∈ [(3039, true), (154, false), (3029, false)])))
    exact False.elim (arith_123 x g0 g1 g2)

private theorem arith_124 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (8 : Int)) (g1 : ((x 2 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_124 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3040, true), (155, false), (3029, false)] := by
  refine if hc : Holds (assignment x) [(3040, true), (155, false), (3029, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3040, true) ∈ [(3040, true), (155, false), (3029, false)])))
    have g1 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (155, false) ∈ [(3040, true), (155, false), (3029, false)])))
    have g2 : ((3 : Int) + (x 1 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3029, false) ∈ [(3040, true), (155, false), (3029, false)])))
    exact False.elim (arith_124 x g0 g1 g2)

private theorem arith_125 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (9 : Int)) (g1 : ((3 : Int) + (x 1 : Int)) = (6 : Int)) (g2 : ((x 2 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_125 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3041, true), (3029, false), (156, false)] := by
  refine if hc : Holds (assignment x) [(3041, true), (3029, false), (156, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3041, true) ∈ [(3041, true), (3029, false), (156, false)])))
    have g1 : ((3 : Int) + (x 1 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3029, false) ∈ [(3041, true), (3029, false), (156, false)])))
    have g2 : ((x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (156, false) ∈ [(3041, true), (3029, false), (156, false)])))
    exact False.elim (arith_125 x g0 g1 g2)

private theorem arith_126 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_126 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3035, false), (3052, true), (195, false)] := by
  refine if hc : Holds (assignment x) [(3035, false), (3052, true), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3035, false) ∈ [(3035, false), (3052, true), (195, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3052, true) ∈ [(3035, false), (3052, true), (195, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(3035, false), (3052, true), (195, false)])))
    exact False.elim (arith_126 x g0 g1 g2)

private theorem arith_127 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (2 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_127 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3035, false), (3051, true), (196, false)] := by
  refine if hc : Holds (assignment x) [(3035, false), (3051, true), (196, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3035, false) ∈ [(3035, false), (3051, true), (196, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3051, true) ∈ [(3035, false), (3051, true), (196, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(3035, false), (3051, true), (196, false)])))
    exact False.elim (arith_127 x g0 g1 g2)

private theorem arith_128 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (1 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_128 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3035, false), (3050, true), (197, false)] := by
  refine if hc : Holds (assignment x) [(3035, false), (3050, true), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3035, false) ∈ [(3035, false), (3050, true), (197, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3050, true) ∈ [(3035, false), (3050, true), (197, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(3035, false), (3050, true), (197, false)])))
    exact False.elim (arith_128 x g0 g1 g2)

private theorem arith_129 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (4 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_129 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3036, false), (3053, true), (195, false)] := by
  refine if hc : Holds (assignment x) [(3036, false), (3053, true), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3036, false) ∈ [(3036, false), (3053, true), (195, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3053, true) ∈ [(3036, false), (3053, true), (195, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(3036, false), (3053, true), (195, false)])))
    exact False.elim (arith_129 x g0 g1 g2)

private theorem arith_130 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_130 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3052, true), (3036, false), (196, false)] := by
  refine if hc : Holds (assignment x) [(3052, true), (3036, false), (196, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3052, true) ∈ [(3052, true), (3036, false), (196, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3036, false) ∈ [(3052, true), (3036, false), (196, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(3052, true), (3036, false), (196, false)])))
    exact False.elim (arith_130 x g0 g1 g2)

private theorem arith_131 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_131 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3051, true), (3036, false), (197, false)] := by
  refine if hc : Holds (assignment x) [(3051, true), (3036, false), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3051, true) ∈ [(3051, true), (3036, false), (197, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3036, false) ∈ [(3051, true), (3036, false), (197, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(3051, true), (3036, false), (197, false)])))
    exact False.elim (arith_131 x g0 g1 g2)

private theorem arith_132 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (1 : Int)) (g2 : ((x 3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_132 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3036, false), (3050, true), (198, false)] := by
  refine if hc : Holds (assignment x) [(3036, false), (3050, true), (198, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3036, false) ∈ [(3036, false), (3050, true), (198, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3050, true) ∈ [(3036, false), (3050, true), (198, false)])))
    have g2 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (198, false) ∈ [(3036, false), (3050, true), (198, false)])))
    exact False.elim (arith_132 x g0 g1 g2)

private theorem arith_133 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (5 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_133 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3037, false), (3054, true), (195, false)] := by
  refine if hc : Holds (assignment x) [(3037, false), (3054, true), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3037, false) ∈ [(3037, false), (3054, true), (195, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3054, true) ∈ [(3037, false), (3054, true), (195, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(3037, false), (3054, true), (195, false)])))
    exact False.elim (arith_133 x g0 g1 g2)

private theorem arith_134 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (4 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_134 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3037, false), (3053, true), (196, false)] := by
  refine if hc : Holds (assignment x) [(3037, false), (3053, true), (196, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3037, false) ∈ [(3037, false), (3053, true), (196, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3053, true) ∈ [(3037, false), (3053, true), (196, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(3037, false), (3053, true), (196, false)])))
    exact False.elim (arith_134 x g0 g1 g2)

private theorem arith_135 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_135 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3037, false), (3052, true), (197, false)] := by
  refine if hc : Holds (assignment x) [(3037, false), (3052, true), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3037, false) ∈ [(3037, false), (3052, true), (197, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3052, true) ∈ [(3037, false), (3052, true), (197, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(3037, false), (3052, true), (197, false)])))
    exact False.elim (arith_135 x g0 g1 g2)

private theorem arith_136 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (2 : Int)) (g2 : ((x 3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_136 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3037, false), (3051, true), (198, false)] := by
  refine if hc : Holds (assignment x) [(3037, false), (3051, true), (198, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3037, false) ∈ [(3037, false), (3051, true), (198, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3051, true) ∈ [(3037, false), (3051, true), (198, false)])))
    have g2 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (198, false) ∈ [(3037, false), (3051, true), (198, false)])))
    exact False.elim (arith_136 x g0 g1 g2)

private theorem arith_137 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (6 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_137 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3038, false), (3055, true), (195, false)] := by
  refine if hc : Holds (assignment x) [(3038, false), (3055, true), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3038, false) ∈ [(3038, false), (3055, true), (195, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3055, true) ∈ [(3038, false), (3055, true), (195, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(3038, false), (3055, true), (195, false)])))
    exact False.elim (arith_137 x g0 g1 g2)

private theorem arith_138 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_138 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3054, true), (3038, false), (196, false)] := by
  refine if hc : Holds (assignment x) [(3054, true), (3038, false), (196, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3054, true) ∈ [(3054, true), (3038, false), (196, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3038, false) ∈ [(3054, true), (3038, false), (196, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(3054, true), (3038, false), (196, false)])))
    exact False.elim (arith_138 x g0 g1 g2)

private theorem arith_139 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (4 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_139 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3038, false), (3053, true), (197, false)] := by
  refine if hc : Holds (assignment x) [(3038, false), (3053, true), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3038, false) ∈ [(3038, false), (3053, true), (197, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3053, true) ∈ [(3038, false), (3053, true), (197, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(3038, false), (3053, true), (197, false)])))
    exact False.elim (arith_139 x g0 g1 g2)

private theorem arith_140 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int)) (g2 : ((x 3 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_140 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3052, true), (3038, false), (198, false)] := by
  refine if hc : Holds (assignment x) [(3052, true), (3038, false), (198, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3052, true) ∈ [(3052, true), (3038, false), (198, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3038, false) ∈ [(3052, true), (3038, false), (198, false)])))
    have g2 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (198, false) ∈ [(3052, true), (3038, false), (198, false)])))
    exact False.elim (arith_140 x g0 g1 g2)

private theorem arith_141 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (2 : Int)) (g2 : ((x 3 : Int)) = (4 : Int)) : False := by
  omega

theorem clause_141 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3038, false), (3051, true), (199, false)] := by
  refine if hc : Holds (assignment x) [(3038, false), (3051, true), (199, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3038, false) ∈ [(3038, false), (3051, true), (199, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3051, true) ∈ [(3038, false), (3051, true), (199, false)])))
    have g2 : ((x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (199, false) ∈ [(3038, false), (3051, true), (199, false)])))
    exact False.elim (arith_141 x g0 g1 g2)

private theorem arith_142 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (7 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_142 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3039, false), (3056, true), (195, false)] := by
  refine if hc : Holds (assignment x) [(3039, false), (3056, true), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3039, false) ∈ [(3039, false), (3056, true), (195, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3056, true) ∈ [(3039, false), (3056, true), (195, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(3039, false), (3056, true), (195, false)])))
    exact False.elim (arith_142 x g0 g1 g2)

private theorem arith_143 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (6 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_143 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3039, false), (3055, true), (196, false)] := by
  refine if hc : Holds (assignment x) [(3039, false), (3055, true), (196, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3039, false) ∈ [(3039, false), (3055, true), (196, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3055, true) ∈ [(3039, false), (3055, true), (196, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(3039, false), (3055, true), (196, false)])))
    exact False.elim (arith_143 x g0 g1 g2)

private theorem arith_144 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (5 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_144 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3039, false), (3054, true), (197, false)] := by
  refine if hc : Holds (assignment x) [(3039, false), (3054, true), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3039, false) ∈ [(3039, false), (3054, true), (197, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3054, true) ∈ [(3039, false), (3054, true), (197, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(3039, false), (3054, true), (197, false)])))
    exact False.elim (arith_144 x g0 g1 g2)

private theorem arith_145 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int)) (g2 : ((x 3 : Int)) = (4 : Int)) : False := by
  omega

theorem clause_145 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3039, false), (3052, true), (199, false)] := by
  refine if hc : Holds (assignment x) [(3039, false), (3052, true), (199, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3039, false) ∈ [(3039, false), (3052, true), (199, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3052, true) ∈ [(3039, false), (3052, true), (199, false)])))
    have g2 : ((x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (199, false) ∈ [(3039, false), (3052, true), (199, false)])))
    exact False.elim (arith_145 x g0 g1 g2)

private theorem arith_146 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (8 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_146 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3040, false), (3057, true), (195, false)] := by
  refine if hc : Holds (assignment x) [(3040, false), (3057, true), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3040, false) ∈ [(3040, false), (3057, true), (195, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3057, true) ∈ [(3040, false), (3057, true), (195, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(3040, false), (3057, true), (195, false)])))
    exact False.elim (arith_146 x g0 g1 g2)

private theorem arith_147 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (7 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_147 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3040, false), (3056, true), (196, false)] := by
  refine if hc : Holds (assignment x) [(3040, false), (3056, true), (196, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3040, false) ∈ [(3040, false), (3056, true), (196, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3056, true) ∈ [(3040, false), (3056, true), (196, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(3040, false), (3056, true), (196, false)])))
    exact False.elim (arith_147 x g0 g1 g2)

private theorem arith_148 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (6 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_148 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3040, false), (3055, true), (197, false)] := by
  refine if hc : Holds (assignment x) [(3040, false), (3055, true), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3040, false) ∈ [(3040, false), (3055, true), (197, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3055, true) ∈ [(3040, false), (3055, true), (197, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(3040, false), (3055, true), (197, false)])))
    exact False.elim (arith_148 x g0 g1 g2)

private theorem arith_149 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (4 : Int)) (g2 : ((x 3 : Int)) = (4 : Int)) : False := by
  omega

theorem clause_149 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3040, false), (3053, true), (199, false)] := by
  refine if hc : Holds (assignment x) [(3040, false), (3053, true), (199, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3040, false) ∈ [(3040, false), (3053, true), (199, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3053, true) ∈ [(3040, false), (3053, true), (199, false)])))
    have g2 : ((x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (199, false) ∈ [(3040, false), (3053, true), (199, false)])))
    exact False.elim (arith_149 x g0 g1 g2)

private theorem arith_150 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (9 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (9 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_150 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3041, false), (3058, true), (195, false)] := by
  refine if hc : Holds (assignment x) [(3041, false), (3058, true), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3041, false) ∈ [(3041, false), (3058, true), (195, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3058, true) ∈ [(3041, false), (3058, true), (195, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(3041, false), (3058, true), (195, false)])))
    exact False.elim (arith_150 x g0 g1 g2)

private theorem arith_151 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (1 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_151 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3050, false), (3071, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(3050, false), (3071, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3050, false) ∈ [(3050, false), (3071, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3071, true) ∈ [(3050, false), (3071, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3050, false), (3071, true), (232, false)])))
    exact False.elim (arith_151 x g0 g1 g2)

private theorem arith_152 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (2 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_152 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3051, false), (3072, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(3051, false), (3072, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3051, false) ∈ [(3051, false), (3072, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3072, true) ∈ [(3051, false), (3072, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3051, false), (3072, true), (232, false)])))
    exact False.elim (arith_152 x g0 g1 g2)

private theorem arith_153 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (1 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_153 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3051, false), (3071, true), (233, false)] := by
  refine if hc : Holds (assignment x) [(3051, false), (3071, true), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3051, false) ∈ [(3051, false), (3071, true), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3071, true) ∈ [(3051, false), (3071, true), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(3051, false), (3071, true), (233, false)])))
    exact False.elim (arith_153 x g0 g1 g2)

private theorem arith_154 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (3 : Int)) (g1 : ((x 4 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (3 : Int)) : False := by
  omega

theorem clause_154 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3073, true), (232, false), (3052, false)] := by
  refine if hc : Holds (assignment x) [(3073, true), (232, false), (3052, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3073, true) ∈ [(3073, true), (232, false), (3052, false)])))
    have g1 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3073, true), (232, false), (3052, false)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3052, false) ∈ [(3073, true), (232, false), (3052, false)])))
    exact False.elim (arith_154 x g0 g1 g2)

private theorem arith_155 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (2 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_155 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3052, false), (3072, true), (233, false)] := by
  refine if hc : Holds (assignment x) [(3052, false), (3072, true), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3052, false) ∈ [(3052, false), (3072, true), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3072, true) ∈ [(3052, false), (3072, true), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(3052, false), (3072, true), (233, false)])))
    exact False.elim (arith_155 x g0 g1 g2)

private theorem arith_156 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (3 : Int)) (g1 : ((x 4 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (1 : Int)) : False := by
  omega

theorem clause_156 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3052, false), (234, false), (3071, true)] := by
  refine if hc : Holds (assignment x) [(3052, false), (234, false), (3071, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3052, false) ∈ [(3052, false), (234, false), (3071, true)])))
    have g1 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(3052, false), (234, false), (3071, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3071, true) ∈ [(3052, false), (234, false), (3071, true)])))
    exact False.elim (arith_156 x g0 g1 g2)

private theorem arith_157 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (4 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_157 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3053, false), (3074, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(3053, false), (3074, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3053, false) ∈ [(3053, false), (3074, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3074, true) ∈ [(3053, false), (3074, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3053, false), (3074, true), (232, false)])))
    exact False.elim (arith_157 x g0 g1 g2)

private theorem arith_158 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_158 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3073, true), (3053, false), (233, false)] := by
  refine if hc : Holds (assignment x) [(3073, true), (3053, false), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3073, true) ∈ [(3073, true), (3053, false), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3053, false) ∈ [(3073, true), (3053, false), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(3073, true), (3053, false), (233, false)])))
    exact False.elim (arith_158 x g0 g1 g2)

private theorem arith_159 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (2 : Int)) (g1 : ((x 4 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int)) : False := by
  omega

theorem clause_159 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3072, true), (234, false), (3053, false)] := by
  refine if hc : Holds (assignment x) [(3072, true), (234, false), (3053, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3072, true) ∈ [(3072, true), (234, false), (3053, false)])))
    have g1 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(3072, true), (234, false), (3053, false)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3053, false) ∈ [(3072, true), (234, false), (3053, false)])))
    exact False.elim (arith_159 x g0 g1 g2)

private theorem arith_160 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int)) (g2 : ((x 4 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_160 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3071, true), (3053, false), (235, false)] := by
  refine if hc : Holds (assignment x) [(3071, true), (3053, false), (235, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3071, true) ∈ [(3071, true), (3053, false), (235, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3053, false) ∈ [(3071, true), (3053, false), (235, false)])))
    have g2 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (235, false) ∈ [(3071, true), (3053, false), (235, false)])))
    exact False.elim (arith_160 x g0 g1 g2)

private theorem arith_161 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (5 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_161 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3054, false), (3075, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(3054, false), (3075, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3054, false) ∈ [(3054, false), (3075, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3075, true) ∈ [(3054, false), (3075, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3054, false), (3075, true), (232, false)])))
    exact False.elim (arith_161 x g0 g1 g2)

private theorem arith_162 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (4 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_162 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3054, false), (3074, true), (233, false)] := by
  refine if hc : Holds (assignment x) [(3054, false), (3074, true), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3054, false) ∈ [(3054, false), (3074, true), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3074, true) ∈ [(3054, false), (3074, true), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(3054, false), (3074, true), (233, false)])))
    exact False.elim (arith_162 x g0 g1 g2)

private theorem arith_163 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int)) (g1 : ((x 4 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (3 : Int)) : False := by
  omega

theorem clause_163 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3054, false), (234, false), (3073, true)] := by
  refine if hc : Holds (assignment x) [(3054, false), (234, false), (3073, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3054, false) ∈ [(3054, false), (234, false), (3073, true)])))
    have g1 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(3054, false), (234, false), (3073, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3073, true) ∈ [(3054, false), (234, false), (3073, true)])))
    exact False.elim (arith_163 x g0 g1 g2)

private theorem arith_164 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (2 : Int)) (g2 : ((x 4 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_164 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3054, false), (3072, true), (235, false)] := by
  refine if hc : Holds (assignment x) [(3054, false), (3072, true), (235, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3054, false) ∈ [(3054, false), (3072, true), (235, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3072, true) ∈ [(3054, false), (3072, true), (235, false)])))
    have g2 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (235, false) ∈ [(3054, false), (3072, true), (235, false)])))
    exact False.elim (arith_164 x g0 g1 g2)

private theorem arith_165 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (6 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_165 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3055, false), (3076, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(3055, false), (3076, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3055, false) ∈ [(3055, false), (3076, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3076, true) ∈ [(3055, false), (3076, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3055, false), (3076, true), (232, false)])))
    exact False.elim (arith_165 x g0 g1 g2)

private theorem arith_166 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (5 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_166 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3055, false), (3075, true), (233, false)] := by
  refine if hc : Holds (assignment x) [(3055, false), (3075, true), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3055, false) ∈ [(3055, false), (3075, true), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3075, true) ∈ [(3055, false), (3075, true), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(3055, false), (3075, true), (233, false)])))
    exact False.elim (arith_166 x g0 g1 g2)

private theorem arith_167 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int)) (g1 : ((x 4 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (4 : Int)) : False := by
  omega

theorem clause_167 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3055, false), (234, false), (3074, true)] := by
  refine if hc : Holds (assignment x) [(3055, false), (234, false), (3074, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3055, false) ∈ [(3055, false), (234, false), (3074, true)])))
    have g1 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(3055, false), (234, false), (3074, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3074, true) ∈ [(3055, false), (234, false), (3074, true)])))
    exact False.elim (arith_167 x g0 g1 g2)

private theorem arith_168 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (3 : Int)) (g2 : ((x 4 : Int)) = (3 : Int)) : False := by
  omega

theorem clause_168 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3055, false), (3073, true), (235, false)] := by
  refine if hc : Holds (assignment x) [(3055, false), (3073, true), (235, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3055, false) ∈ [(3055, false), (3073, true), (235, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3073, true) ∈ [(3055, false), (3073, true), (235, false)])))
    have g2 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (235, false) ∈ [(3055, false), (3073, true), (235, false)])))
    exact False.elim (arith_168 x g0 g1 g2)

private theorem arith_169 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (7 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_169 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3056, false), (3077, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(3056, false), (3077, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3056, false) ∈ [(3056, false), (3077, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3077, true) ∈ [(3056, false), (3077, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3056, false), (3077, true), (232, false)])))
    exact False.elim (arith_169 x g0 g1 g2)

private theorem arith_170 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (6 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_170 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3056, false), (3076, true), (233, false)] := by
  refine if hc : Holds (assignment x) [(3056, false), (3076, true), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3056, false) ∈ [(3056, false), (3076, true), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3076, true) ∈ [(3056, false), (3076, true), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(3056, false), (3076, true), (233, false)])))
    exact False.elim (arith_170 x g0 g1 g2)

private theorem arith_171 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (7 : Int)) (g1 : ((x 4 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (5 : Int)) : False := by
  omega

theorem clause_171 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3056, false), (234, false), (3075, true)] := by
  refine if hc : Holds (assignment x) [(3056, false), (234, false), (3075, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3056, false) ∈ [(3056, false), (234, false), (3075, true)])))
    have g1 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(3056, false), (234, false), (3075, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3075, true) ∈ [(3056, false), (234, false), (3075, true)])))
    exact False.elim (arith_171 x g0 g1 g2)

private theorem arith_172 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (8 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_172 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3057, false), (3078, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(3057, false), (3078, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3057, false) ∈ [(3057, false), (3078, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3078, true) ∈ [(3057, false), (3078, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3057, false), (3078, true), (232, false)])))
    exact False.elim (arith_172 x g0 g1 g2)

private theorem arith_173 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (7 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_173 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3057, false), (3077, true), (233, false)] := by
  refine if hc : Holds (assignment x) [(3057, false), (3077, true), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3057, false) ∈ [(3057, false), (3077, true), (233, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3077, true) ∈ [(3057, false), (3077, true), (233, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(3057, false), (3077, true), (233, false)])))
    exact False.elim (arith_173 x g0 g1 g2)

private theorem arith_174 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (9 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (9 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_174 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3058, false), (3079, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(3058, false), (3079, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int))) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3058, false) ∈ [(3058, false), (3079, true), (232, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3079, true) ∈ [(3058, false), (3079, true), (232, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(3058, false), (3079, true), (232, false)])))
    exact False.elim (arith_174 x g0 g1 g2)

private theorem arith_175 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (1 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int)) : False := by
  omega

theorem clause_175 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3071, false), (264, false), (3096, true)] := by
  refine if hc : Holds (assignment x) [(3071, false), (264, false), (3096, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3071, false) ∈ [(3071, false), (264, false), (3096, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3071, false), (264, false), (3096, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3096, true) ∈ [(3071, false), (264, false), (3096, true)])))
    exact False.elim (arith_175 x g0 g1 g2)

private theorem arith_176 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (2 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int)) : False := by
  omega

theorem clause_176 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3072, false), (264, false), (3097, true)] := by
  refine if hc : Holds (assignment x) [(3072, false), (264, false), (3097, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3072, false) ∈ [(3072, false), (264, false), (3097, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3072, false), (264, false), (3097, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3097, true) ∈ [(3072, false), (264, false), (3097, true)])))
    exact False.elim (arith_176 x g0 g1 g2)

private theorem arith_177 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int)) : False := by
  omega

theorem clause_177 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(265, false), (3072, false), (3096, true)] := by
  refine if hc : Holds (assignment x) [(265, false), (3072, false), (3096, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(265, false), (3072, false), (3096, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3072, false) ∈ [(265, false), (3072, false), (3096, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3096, true) ∈ [(265, false), (3072, false), (3096, true)])))
    exact False.elim (arith_177 x g0 g1 g2)

private theorem arith_178 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (3 : Int)) : False := by
  omega

theorem clause_178 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3073, false), (264, false), (3098, true)] := by
  refine if hc : Holds (assignment x) [(3073, false), (264, false), (3098, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3073, false) ∈ [(3073, false), (264, false), (3098, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3073, false), (264, false), (3098, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3098, true) ∈ [(3073, false), (264, false), (3098, true)])))
    exact False.elim (arith_178 x g0 g1 g2)

private theorem arith_179 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int)) : False := by
  omega

theorem clause_179 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(265, false), (3073, false), (3097, true)] := by
  refine if hc : Holds (assignment x) [(265, false), (3073, false), (3097, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(265, false), (3073, false), (3097, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3073, false) ∈ [(265, false), (3073, false), (3097, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3097, true) ∈ [(265, false), (3073, false), (3097, true)])))
    exact False.elim (arith_179 x g0 g1 g2)

private theorem arith_180 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int)) : False := by
  omega

theorem clause_180 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(266, false), (3073, false), (3096, true)] := by
  refine if hc : Holds (assignment x) [(266, false), (3073, false), (3096, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (266, false) ∈ [(266, false), (3073, false), (3096, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3073, false) ∈ [(266, false), (3073, false), (3096, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3096, true) ∈ [(266, false), (3073, false), (3096, true)])))
    exact False.elim (arith_180 x g0 g1 g2)

private theorem arith_181 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (-1 : Int)) : False := by
  omega

theorem clause_181 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(268, false), (3073, false), (3084, true)] := by
  refine if hc : Holds (assignment x) [(268, false), (3073, false), (3084, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (268, false) ∈ [(268, false), (3073, false), (3084, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3073, false) ∈ [(268, false), (3073, false), (3084, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (-1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3084, true) ∈ [(268, false), (3073, false), (3084, true)])))
    exact False.elim (arith_181 x g0 g1 g2)

private theorem arith_182 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (4 : Int)) : False := by
  omega

theorem clause_182 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3074, false), (264, false), (3099, true)] := by
  refine if hc : Holds (assignment x) [(3074, false), (264, false), (3099, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3074, false) ∈ [(3074, false), (264, false), (3099, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3074, false), (264, false), (3099, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3099, true) ∈ [(3074, false), (264, false), (3099, true)])))
    exact False.elim (arith_182 x g0 g1 g2)

private theorem arith_183 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (3 : Int)) : False := by
  omega

theorem clause_183 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(265, false), (3074, false), (3098, true)] := by
  refine if hc : Holds (assignment x) [(265, false), (3074, false), (3098, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(265, false), (3074, false), (3098, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3074, false) ∈ [(265, false), (3074, false), (3098, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3098, true) ∈ [(265, false), (3074, false), (3098, true)])))
    exact False.elim (arith_183 x g0 g1 g2)

private theorem arith_184 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int)) : False := by
  omega

theorem clause_184 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(266, false), (3074, false), (3097, true)] := by
  refine if hc : Holds (assignment x) [(266, false), (3074, false), (3097, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (266, false) ∈ [(266, false), (3074, false), (3097, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3074, false) ∈ [(266, false), (3074, false), (3097, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3097, true) ∈ [(266, false), (3074, false), (3097, true)])))
    exact False.elim (arith_184 x g0 g1 g2)

private theorem arith_185 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int)) : False := by
  omega

theorem clause_185 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(267, false), (3074, false), (3096, true)] := by
  refine if hc : Holds (assignment x) [(267, false), (3074, false), (3096, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (267, false) ∈ [(267, false), (3074, false), (3096, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3074, false) ∈ [(267, false), (3074, false), (3096, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3096, true) ∈ [(267, false), (3074, false), (3096, true)])))
    exact False.elim (arith_185 x g0 g1 g2)

private theorem arith_186 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (5 : Int)) : False := by
  omega

theorem clause_186 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3075, false), (264, false), (3100, true)] := by
  refine if hc : Holds (assignment x) [(3075, false), (264, false), (3100, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3075, false) ∈ [(3075, false), (264, false), (3100, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3075, false), (264, false), (3100, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3100, true) ∈ [(3075, false), (264, false), (3100, true)])))
    exact False.elim (arith_186 x g0 g1 g2)

private theorem arith_187 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (4 : Int)) : False := by
  omega

theorem clause_187 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(265, false), (3075, false), (3099, true)] := by
  refine if hc : Holds (assignment x) [(265, false), (3075, false), (3099, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(265, false), (3075, false), (3099, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3075, false) ∈ [(265, false), (3075, false), (3099, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3099, true) ∈ [(265, false), (3075, false), (3099, true)])))
    exact False.elim (arith_187 x g0 g1 g2)

private theorem arith_188 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (3 : Int)) : False := by
  omega

theorem clause_188 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(266, false), (3075, false), (3098, true)] := by
  refine if hc : Holds (assignment x) [(266, false), (3075, false), (3098, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (266, false) ∈ [(266, false), (3075, false), (3098, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3075, false) ∈ [(266, false), (3075, false), (3098, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3098, true) ∈ [(266, false), (3075, false), (3098, true)])))
    exact False.elim (arith_188 x g0 g1 g2)

private theorem arith_189 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int)) (g1 : ((x 5 : Int)) = (3 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int)) : False := by
  omega

theorem clause_189 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3075, false), (267, false), (3097, true)] := by
  refine if hc : Holds (assignment x) [(3075, false), (267, false), (3097, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3075, false) ∈ [(3075, false), (267, false), (3097, true)])))
    have g1 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (267, false) ∈ [(3075, false), (267, false), (3097, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3097, true) ∈ [(3075, false), (267, false), (3097, true)])))
    exact False.elim (arith_189 x g0 g1 g2)

private theorem arith_190 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int)) (g1 : ((x 5 : Int)) = (4 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int)) : False := by
  omega

theorem clause_190 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3075, false), (268, false), (3096, true)] := by
  refine if hc : Holds (assignment x) [(3075, false), (268, false), (3096, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3075, false) ∈ [(3075, false), (268, false), (3096, true)])))
    have g1 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (268, false) ∈ [(3075, false), (268, false), (3096, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3096, true) ∈ [(3075, false), (268, false), (3096, true)])))
    exact False.elim (arith_190 x g0 g1 g2)

private theorem arith_191 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (6 : Int)) : False := by
  omega

theorem clause_191 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3076, false), (264, false), (3101, true)] := by
  refine if hc : Holds (assignment x) [(3076, false), (264, false), (3101, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3076, false) ∈ [(3076, false), (264, false), (3101, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3076, false), (264, false), (3101, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3101, true) ∈ [(3076, false), (264, false), (3101, true)])))
    exact False.elim (arith_191 x g0 g1 g2)

private theorem arith_192 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int)) (g1 : ((x 5 : Int)) = (1 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (5 : Int)) : False := by
  omega

theorem clause_192 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3076, false), (265, false), (3100, true)] := by
  refine if hc : Holds (assignment x) [(3076, false), (265, false), (3100, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3076, false) ∈ [(3076, false), (265, false), (3100, true)])))
    have g1 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(3076, false), (265, false), (3100, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3100, true) ∈ [(3076, false), (265, false), (3100, true)])))
    exact False.elim (arith_192 x g0 g1 g2)

private theorem arith_193 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (4 : Int)) : False := by
  omega

theorem clause_193 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(266, false), (3076, false), (3099, true)] := by
  refine if hc : Holds (assignment x) [(266, false), (3076, false), (3099, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (266, false) ∈ [(266, false), (3076, false), (3099, true)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3076, false) ∈ [(266, false), (3076, false), (3099, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3099, true) ∈ [(266, false), (3076, false), (3099, true)])))
    exact False.elim (arith_193 x g0 g1 g2)

private theorem arith_194 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int)) (g1 : ((x 5 : Int)) = (3 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (3 : Int)) : False := by
  omega

theorem clause_194 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3076, false), (267, false), (3098, true)] := by
  refine if hc : Holds (assignment x) [(3076, false), (267, false), (3098, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3076, false) ∈ [(3076, false), (267, false), (3098, true)])))
    have g1 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (267, false) ∈ [(3076, false), (267, false), (3098, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3098, true) ∈ [(3076, false), (267, false), (3098, true)])))
    exact False.elim (arith_194 x g0 g1 g2)

private theorem arith_195 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int)) (g1 : ((x 5 : Int)) = (4 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int)) : False := by
  omega

theorem clause_195 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3076, false), (268, false), (3097, true)] := by
  refine if hc : Holds (assignment x) [(3076, false), (268, false), (3097, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3076, false) ∈ [(3076, false), (268, false), (3097, true)])))
    have g1 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (268, false) ∈ [(3076, false), (268, false), (3097, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3097, true) ∈ [(3076, false), (268, false), (3097, true)])))
    exact False.elim (arith_195 x g0 g1 g2)

private theorem arith_196 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (7 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (7 : Int)) : False := by
  omega

theorem clause_196 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3077, false), (264, false), (3102, true)] := by
  refine if hc : Holds (assignment x) [(3077, false), (264, false), (3102, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3077, false) ∈ [(3077, false), (264, false), (3102, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3077, false), (264, false), (3102, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3102, true) ∈ [(3077, false), (264, false), (3102, true)])))
    exact False.elim (arith_196 x g0 g1 g2)

private theorem arith_197 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (7 : Int)) (g1 : ((x 5 : Int)) = (1 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (6 : Int)) : False := by
  omega

theorem clause_197 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3077, false), (265, false), (3101, true)] := by
  refine if hc : Holds (assignment x) [(3077, false), (265, false), (3101, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3077, false) ∈ [(3077, false), (265, false), (3101, true)])))
    have g1 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(3077, false), (265, false), (3101, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3101, true) ∈ [(3077, false), (265, false), (3101, true)])))
    exact False.elim (arith_197 x g0 g1 g2)

private theorem arith_198 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (7 : Int)) (g1 : ((x 5 : Int)) = (2 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (5 : Int)) : False := by
  omega

theorem clause_198 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3077, false), (266, false), (3100, true)] := by
  refine if hc : Holds (assignment x) [(3077, false), (266, false), (3100, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3077, false) ∈ [(3077, false), (266, false), (3100, true)])))
    have g1 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (266, false) ∈ [(3077, false), (266, false), (3100, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (5 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3100, true) ∈ [(3077, false), (266, false), (3100, true)])))
    exact False.elim (arith_198 x g0 g1 g2)

private theorem arith_199 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (8 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (8 : Int)) : False := by
  omega

theorem clause_199 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3078, false), (264, false), (3103, true)] := by
  refine if hc : Holds (assignment x) [(3078, false), (264, false), (3103, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3078, false) ∈ [(3078, false), (264, false), (3103, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3078, false), (264, false), (3103, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3103, true) ∈ [(3078, false), (264, false), (3103, true)])))
    exact False.elim (arith_199 x g0 g1 g2)

private theorem arith_200 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (8 : Int)) (g1 : ((x 5 : Int)) = (1 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (7 : Int)) : False := by
  omega

theorem clause_200 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3078, false), (265, false), (3102, true)] := by
  refine if hc : Holds (assignment x) [(3078, false), (265, false), (3102, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3078, false) ∈ [(3078, false), (265, false), (3102, true)])))
    have g1 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(3078, false), (265, false), (3102, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3102, true) ∈ [(3078, false), (265, false), (3102, true)])))
    exact False.elim (arith_200 x g0 g1 g2)

private theorem arith_201 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (9 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (9 : Int)) : False := by
  omega

theorem clause_201 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3079, false), (264, false), (3104, true)] := by
  refine if hc : Holds (assignment x) [(3079, false), (264, false), (3104, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int))) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3079, false) ∈ [(3079, false), (264, false), (3104, true)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(3079, false), (264, false), (3104, true)])))
    have g2 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3104, true) ∈ [(3079, false), (264, false), (3104, true)])))
    exact False.elim (arith_201 x g0 g1 g2)

private theorem arith_202 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (-1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_202 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3084, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3084, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (-1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3084, false) ∈ [(3084, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3084, false), (3083, false)])))
    exact False.elim (arith_202 x g0 g1)

private theorem arith_203 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (1 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_203 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3096, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3096, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3096, false) ∈ [(3096, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3096, false), (3083, false)])))
    exact False.elim (arith_203 x g0 g1)

private theorem arith_204 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (2 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_204 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3097, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3097, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3097, false) ∈ [(3097, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3097, false), (3083, false)])))
    exact False.elim (arith_204 x g0 g1)

private theorem arith_205 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (3 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_205 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3098, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3098, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3098, false) ∈ [(3098, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3098, false), (3083, false)])))
    exact False.elim (arith_205 x g0 g1)

private theorem arith_206 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (4 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_206 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3099, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3099, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3099, false) ∈ [(3099, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3099, false), (3083, false)])))
    exact False.elim (arith_206 x g0 g1)

private theorem arith_207 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (5 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_207 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3100, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3100, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (5 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3100, false) ∈ [(3100, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3100, false), (3083, false)])))
    exact False.elim (arith_207 x g0 g1)

private theorem arith_208 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (6 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_208 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3101, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3101, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3101, false) ∈ [(3101, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3101, false), (3083, false)])))
    exact False.elim (arith_208 x g0 g1)

private theorem arith_209 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (7 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_209 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3102, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3102, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3102, false) ∈ [(3102, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3102, false), (3083, false)])))
    exact False.elim (arith_209 x g0 g1)

private theorem arith_210 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (8 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_210 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3103, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3103, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3103, false) ∈ [(3103, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3103, false), (3083, false)])))
    exact False.elim (arith_210 x g0 g1)

private theorem arith_211 (x : Fin 12 → Nat)
    (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (9 : Int)) (g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int)) : False := by
  omega

theorem clause_211 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3104, false), (3083, false)] := by
  refine if hc : Holds (assignment x) [(3104, false), (3083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3104, false) ∈ [(3104, false), (3083, false)])))
    have g1 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3083, false) ∈ [(3104, false), (3083, false)])))
    exact False.elim (arith_211 x g0 g1)

private theorem arith_212 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0+x 1+x 2 = x 3+x 4+x 5) (g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (0 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_212 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3083, true)] := by
  refine if hc : Holds (assignment x) [(3083, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int) + (x 1 : Int) + (x 2 : Int) + (-1 * (x 3 : Int)) + (-1 * (x 4 : Int)) + (-1 * (x 5 : Int))) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3083, true) ∈ [(3083, true)])))
    exact False.elim (arith_212 x h.zero h.balance g0)

private theorem arith_213 (x : Fin 12 → Nat)
    (hb : x 0 ≤ 4) (g0 : ((6 : Int)) ≠ (6 : Int)) (g1 : ((3 : Int)) = (3 : Int)) (g2 : ((2 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 0) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_213 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6222, true), (57, false), (3, false)] := by
  refine if hc : Holds (assignment x) [(6222, true), (57, false), (3, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6222, true) ∈ [(6222, true), (57, false), (3, false)])))
    have g1 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (57, false) ∈ [(6222, true), (57, false), (3, false)])))
    have g2 : ((2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (3, false) ∈ [(6222, true), (57, false), (3, false)])))
    exact False.elim (arith_213 x (h.bound 0) g0 g1 g2)

private theorem arith_214 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : (0 : Int) ≠ (0 : Int)) (g1 : ((x 1 : Int)) = (0 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_214 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6224, true), (106, false), (4, false)] := by
  refine if hc : Holds (assignment x) [(6224, true), (106, false), (4, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6224, true) ∈ [(6224, true), (106, false), (4, false)])))
    have g1 : ((x 1 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (106, false) ∈ [(6224, true), (106, false), (4, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (4, false) ∈ [(6224, true), (106, false), (4, false)])))
    exact False.elim (arith_214 x (h.bound 1) g0 g1 g2)

private theorem arith_215 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : (0 : Int) ≠ (0 : Int)) (g1 : ((x 1 : Int)) = (1 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_215 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6224, true), (107, false), (4, false)] := by
  refine if hc : Holds (assignment x) [(6224, true), (107, false), (4, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6224, true) ∈ [(6224, true), (107, false), (4, false)])))
    have g1 : ((x 1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (107, false) ∈ [(6224, true), (107, false), (4, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (4, false) ∈ [(6224, true), (107, false), (4, false)])))
    exact False.elim (arith_215 x (h.bound 1) g0 g1 g2)

private theorem arith_216 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : (0 : Int) ≠ (0 : Int)) (g1 : ((x 1 : Int)) = (2 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_216 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6224, true), (108, false), (4, false)] := by
  refine if hc : Holds (assignment x) [(6224, true), (108, false), (4, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6224, true) ∈ [(6224, true), (108, false), (4, false)])))
    have g1 : ((x 1 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (108, false) ∈ [(6224, true), (108, false), (4, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (4, false) ∈ [(6224, true), (108, false), (4, false)])))
    exact False.elim (arith_216 x (h.bound 1) g0 g1 g2)

private theorem arith_217 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : (0 : Int) ≠ (0 : Int)) (g1 : ((x 1 : Int)) = (3 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_217 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6224, true), (109, false), (4, false)] := by
  refine if hc : Holds (assignment x) [(6224, true), (109, false), (4, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6224, true) ∈ [(6224, true), (109, false), (4, false)])))
    have g1 : ((x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (109, false) ∈ [(6224, true), (109, false), (4, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (4, false) ∈ [(6224, true), (109, false), (4, false)])))
    exact False.elim (arith_217 x (h.bound 1) g0 g1 g2)

private theorem arith_218 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) ≠ (1 : Int)) (g1 : ((x 2 : Int)) ≠ (2 : Int)) (g2 : ((x 2 : Int)) ≠ (4 : Int)) (g3 : ((x 2 : Int)) ≠ (3 : Int)) (g4 : ((x 2 : Int)) ≠ (6 : Int)) (g5 : ((x 2 : Int)) ≠ (0 : Int)) (g6 : ((x 2 : Int)) ≠ (8 : Int)) (g7 : ((x 2 : Int)) ≠ (9 : Int)) (g8 : ((x 2 : Int)) ≠ (12 : Int)) (g9 : ((x 2 : Int)) ≠ (16 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_218 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)] := by
  refine if hc : Holds (assignment x) [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6235, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g1 : ((x 2 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6236, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g2 : ((x 2 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6238, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g3 : ((x 2 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6237, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g4 : ((x 2 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6239, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g5 : ((x 2 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6234, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g6 : ((x 2 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6240, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g7 : ((x 2 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6241, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g8 : ((x 2 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6242, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    have g9 : ((x 2 : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6243, true) ∈ [(6235, true), (6236, true), (6238, true), (6237, true), (6239, true), (6234, true), (6240, true), (6241, true), (6242, true), (6243, true)])))
    exact False.elim (arith_218 x (h.bound 2) g0 g1 g2 g3 g4 g5 g6 g7 g8 g9)

private theorem arith_219 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) ≠ (0 : Int)) (g1 : ((x 2 : Int)) = (0 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_219 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6234, true), (153, false), (10, false)] := by
  refine if hc : Holds (assignment x) [(6234, true), (153, false), (10, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6234, true) ∈ [(6234, true), (153, false), (10, false)])))
    have g1 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(6234, true), (153, false), (10, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (10, false) ∈ [(6234, true), (153, false), (10, false)])))
    exact False.elim (arith_219 x (h.bound 2) g0 g1 g2)

private theorem arith_220 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) ≠ (1 : Int)) (g1 : ((x 2 : Int)) = (1 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_220 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6235, true), (154, false), (10, false)] := by
  refine if hc : Holds (assignment x) [(6235, true), (154, false), (10, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6235, true) ∈ [(6235, true), (154, false), (10, false)])))
    have g1 : ((x 2 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (154, false) ∈ [(6235, true), (154, false), (10, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (10, false) ∈ [(6235, true), (154, false), (10, false)])))
    exact False.elim (arith_220 x (h.bound 2) g0 g1 g2)

private theorem arith_221 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) = (2 : Int)) (g1 : ((x 2 : Int)) ≠ (2 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_221 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(155, false), (6236, true), (10, false)] := by
  refine if hc : Holds (assignment x) [(155, false), (6236, true), (10, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (155, false) ∈ [(155, false), (6236, true), (10, false)])))
    have g1 : ((x 2 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6236, true) ∈ [(155, false), (6236, true), (10, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (10, false) ∈ [(155, false), (6236, true), (10, false)])))
    exact False.elim (arith_221 x (h.bound 2) g0 g1 g2)

private theorem arith_222 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : ((x 2 : Int)) ≠ (3 : Int)) (g1 : ((x 2 : Int)) = (3 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_222 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6237, true), (156, false), (10, false)] := by
  refine if hc : Holds (assignment x) [(6237, true), (156, false), (10, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6237, true) ∈ [(6237, true), (156, false), (10, false)])))
    have g1 : ((x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (156, false) ∈ [(6237, true), (156, false), (10, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (10, false) ∈ [(6237, true), (156, false), (10, false)])))
    exact False.elim (arith_222 x (h.bound 2) g0 g1 g2)

private theorem arith_223 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) = (0 : Int)) (g1 : ((x 3 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_223 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6244, false), (6246, false)] := by
  refine if hc : Holds (assignment x) [(6244, false), (6246, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6244, false) ∈ [(6244, false), (6246, false)])))
    have g1 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6246, false) ∈ [(6244, false), (6246, false)])))
    exact False.elim (arith_223 x (h.bound 3) g0 g1)

private theorem arith_224 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) = (1 : Int)) (g1 : ((x 3 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_224 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6245, false), (6246, false)] := by
  refine if hc : Holds (assignment x) [(6245, false), (6246, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6245, false) ∈ [(6245, false), (6246, false)])))
    have g1 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6246, false) ∈ [(6245, false), (6246, false)])))
    exact False.elim (arith_224 x (h.bound 3) g0 g1)

private theorem arith_225 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) = (3 : Int)) (g1 : ((x 3 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_225 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6247, false), (6246, false)] := by
  refine if hc : Holds (assignment x) [(6247, false), (6246, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6247, false) ∈ [(6247, false), (6246, false)])))
    have g1 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6246, false) ∈ [(6247, false), (6246, false)])))
    exact False.elim (arith_225 x (h.bound 3) g0 g1)

private theorem arith_226 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) = (0 : Int)) (g1 : ((x 3 : Int)) ≠ (0 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_226 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(195, false), (6244, true), (15, false)] := by
  refine if hc : Holds (assignment x) [(195, false), (6244, true), (15, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(195, false), (6244, true), (15, false)])))
    have g1 : ((x 3 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6244, true) ∈ [(195, false), (6244, true), (15, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (15, false) ∈ [(195, false), (6244, true), (15, false)])))
    exact False.elim (arith_226 x (h.bound 3) g0 g1 g2)

private theorem arith_227 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) ≠ (1 : Int)) (g1 : ((x 3 : Int)) = (1 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_227 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6245, true), (196, false), (15, false)] := by
  refine if hc : Holds (assignment x) [(6245, true), (196, false), (15, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6245, true) ∈ [(6245, true), (196, false), (15, false)])))
    have g1 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(6245, true), (196, false), (15, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (15, false) ∈ [(6245, true), (196, false), (15, false)])))
    exact False.elim (arith_227 x (h.bound 3) g0 g1 g2)

private theorem arith_228 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) ≠ (2 : Int)) (g1 : ((x 3 : Int)) = (2 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_228 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6246, true), (197, false), (15, false)] := by
  refine if hc : Holds (assignment x) [(6246, true), (197, false), (15, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6246, true) ∈ [(6246, true), (197, false), (15, false)])))
    have g1 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(6246, true), (197, false), (15, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (15, false) ∈ [(6246, true), (197, false), (15, false)])))
    exact False.elim (arith_228 x (h.bound 3) g0 g1 g2)

private theorem arith_229 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) = (3 : Int)) (g1 : ((x 3 : Int)) ≠ (3 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_229 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(198, false), (6247, true), (15, false)] := by
  refine if hc : Holds (assignment x) [(198, false), (6247, true), (15, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (198, false) ∈ [(198, false), (6247, true), (15, false)])))
    have g1 : ((x 3 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6247, true) ∈ [(198, false), (6247, true), (15, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (15, false) ∈ [(198, false), (6247, true), (15, false)])))
    exact False.elim (arith_229 x (h.bound 3) g0 g1 g2)

private theorem arith_230 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : ((x 3 : Int)) ≠ (4 : Int)) (g1 : ((x 3 : Int)) = (4 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_230 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6248, true), (199, false), (15, false)] := by
  refine if hc : Holds (assignment x) [(6248, true), (199, false), (15, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6248, true) ∈ [(6248, true), (199, false), (15, false)])))
    have g1 : ((x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (199, false) ∈ [(6248, true), (199, false), (15, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (15, false) ∈ [(6248, true), (199, false), (15, false)])))
    exact False.elim (arith_230 x (h.bound 3) g0 g1 g2)

private theorem arith_231 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (0 : Int)) (g1 : ((x 4 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_231 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6254, false), (6255, false)] := by
  refine if hc : Holds (assignment x) [(6254, false), (6255, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6254, false), (6255, false)])))
    have g1 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6254, false), (6255, false)])))
    exact False.elim (arith_231 x (h.bound 4) g0 g1)

private theorem arith_232 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (2 : Int)) (g1 : ((x 4 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_232 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6256, false), (6254, false)] := by
  refine if hc : Holds (assignment x) [(6256, false), (6254, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6256, false) ∈ [(6256, false), (6254, false)])))
    have g1 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6256, false), (6254, false)])))
    exact False.elim (arith_232 x (h.bound 4) g0 g1)

private theorem arith_233 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (3 : Int)) (g1 : ((x 4 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_233 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6257, false), (6254, false)] := by
  refine if hc : Holds (assignment x) [(6257, false), (6254, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6257, false), (6254, false)])))
    have g1 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6257, false), (6254, false)])))
    exact False.elim (arith_233 x (h.bound 4) g0 g1)

private theorem arith_234 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (1 : Int)) (g1 : ((x 4 : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_234 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6255, false), (6258, false)] := by
  refine if hc : Holds (assignment x) [(6255, false), (6258, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6255, false), (6258, false)])))
    have g1 : ((x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6258, false) ∈ [(6255, false), (6258, false)])))
    exact False.elim (arith_234 x (h.bound 4) g0 g1)

private theorem arith_235 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (3 : Int)) (g1 : ((x 4 : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_235 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6257, false), (6258, false)] := by
  refine if hc : Holds (assignment x) [(6257, false), (6258, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6257, false), (6258, false)])))
    have g1 : ((x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6258, false) ∈ [(6257, false), (6258, false)])))
    exact False.elim (arith_235 x (h.bound 4) g0 g1)

private theorem arith_236 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (0 : Int)) (g1 : ((x 4 : Int)) ≠ (0 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_236 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(232, false), (6254, true), (20, false)] := by
  refine if hc : Holds (assignment x) [(232, false), (6254, true), (20, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(232, false), (6254, true), (20, false)])))
    have g1 : ((x 4 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6254, true) ∈ [(232, false), (6254, true), (20, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (20, false) ∈ [(232, false), (6254, true), (20, false)])))
    exact False.elim (arith_236 x (h.bound 4) g0 g1 g2)

private theorem arith_237 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) ≠ (1 : Int)) (g1 : ((x 4 : Int)) = (1 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_237 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6255, true), (233, false), (20, false)] := by
  refine if hc : Holds (assignment x) [(6255, true), (233, false), (20, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6255, true) ∈ [(6255, true), (233, false), (20, false)])))
    have g1 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(6255, true), (233, false), (20, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (20, false) ∈ [(6255, true), (233, false), (20, false)])))
    exact False.elim (arith_237 x (h.bound 4) g0 g1 g2)

private theorem arith_238 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (2 : Int)) (g1 : ((x 4 : Int)) ≠ (2 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_238 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(234, false), (6256, true), (20, false)] := by
  refine if hc : Holds (assignment x) [(234, false), (6256, true), (20, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(234, false), (6256, true), (20, false)])))
    have g1 : ((x 4 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6256, true) ∈ [(234, false), (6256, true), (20, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (20, false) ∈ [(234, false), (6256, true), (20, false)])))
    exact False.elim (arith_238 x (h.bound 4) g0 g1 g2)

private theorem arith_239 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (3 : Int)) (g1 : ((x 4 : Int)) ≠ (3 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_239 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(235, false), (6257, true), (20, false)] := by
  refine if hc : Holds (assignment x) [(235, false), (6257, true), (20, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (235, false) ∈ [(235, false), (6257, true), (20, false)])))
    have g1 : ((x 4 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6257, true) ∈ [(235, false), (6257, true), (20, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (20, false) ∈ [(235, false), (6257, true), (20, false)])))
    exact False.elim (arith_239 x (h.bound 4) g0 g1 g2)

private theorem arith_240 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) ≠ (4 : Int)) (g1 : ((x 4 : Int)) = (4 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_240 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6258, true), (236, false), (20, false)] := by
  refine if hc : Holds (assignment x) [(6258, true), (236, false), (20, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6258, true) ∈ [(6258, true), (236, false), (20, false)])))
    have g1 : ((x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (236, false) ∈ [(6258, true), (236, false), (20, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (20, false) ∈ [(6258, true), (236, false), (20, false)])))
    exact False.elim (arith_240 x (h.bound 4) g0 g1 g2)

private theorem arith_241 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) ≠ (0 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_241 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6264, true), (264, false), (25, false)] := by
  refine if hc : Holds (assignment x) [(6264, true), (264, false), (25, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6264, true) ∈ [(6264, true), (264, false), (25, false)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(6264, true), (264, false), (25, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25, false) ∈ [(6264, true), (264, false), (25, false)])))
    exact False.elim (arith_241 x (h.bound 5) g0 g1 g2)

private theorem arith_242 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((x 5 : Int)) ≠ (1 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_242 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(265, false), (6265, true), (25, false)] := by
  refine if hc : Holds (assignment x) [(265, false), (6265, true), (25, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(265, false), (6265, true), (25, false)])))
    have g1 : ((x 5 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6265, true) ∈ [(265, false), (6265, true), (25, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25, false) ∈ [(265, false), (6265, true), (25, false)])))
    exact False.elim (arith_242 x (h.bound 5) g0 g1 g2)

private theorem arith_243 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((x 5 : Int)) ≠ (2 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_243 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(266, false), (6266, true), (25, false)] := by
  refine if hc : Holds (assignment x) [(266, false), (6266, true), (25, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (266, false) ∈ [(266, false), (6266, true), (25, false)])))
    have g1 : ((x 5 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6266, true) ∈ [(266, false), (6266, true), (25, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25, false) ∈ [(266, false), (6266, true), (25, false)])))
    exact False.elim (arith_243 x (h.bound 5) g0 g1 g2)

private theorem arith_244 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) = (3 : Int)) (g1 : ((x 5 : Int)) ≠ (3 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_244 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(267, false), (6267, true), (25, false)] := by
  refine if hc : Holds (assignment x) [(267, false), (6267, true), (25, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (267, false) ∈ [(267, false), (6267, true), (25, false)])))
    have g1 : ((x 5 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6267, true) ∈ [(267, false), (6267, true), (25, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25, false) ∈ [(267, false), (6267, true), (25, false)])))
    exact False.elim (arith_244 x (h.bound 5) g0 g1 g2)

private theorem arith_245 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) = (4 : Int)) (g1 : ((x 5 : Int)) ≠ (4 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_245 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(268, false), (6268, true), (25, false)] := by
  refine if hc : Holds (assignment x) [(268, false), (6268, true), (25, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (268, false) ∈ [(268, false), (6268, true), (25, false)])))
    have g1 : ((x 5 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6268, true) ∈ [(268, false), (6268, true), (25, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25, false) ∈ [(268, false), (6268, true), (25, false)])))
    exact False.elim (arith_245 x (h.bound 5) g0 g1 g2)

private theorem arith_246 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : (0 : Int) ≠ (0 : Int)) (g1 : ((x 6 : Int)) = (0 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_246 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6274, true), (291, false), (29, false)] := by
  refine if hc : Holds (assignment x) [(6274, true), (291, false), (29, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6274, true) ∈ [(6274, true), (291, false), (29, false)])))
    have g1 : ((x 6 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (291, false) ∈ [(6274, true), (291, false), (29, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (29, false) ∈ [(6274, true), (291, false), (29, false)])))
    exact False.elim (arith_246 x (h.bound 6) g0 g1 g2)

private theorem arith_247 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : (0 : Int) ≠ (0 : Int)) (g1 : ((x 6 : Int)) = (1 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_247 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6274, true), (292, false), (29, false)] := by
  refine if hc : Holds (assignment x) [(6274, true), (292, false), (29, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6274, true) ∈ [(6274, true), (292, false), (29, false)])))
    have g1 : ((x 6 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (292, false) ∈ [(6274, true), (292, false), (29, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (29, false) ∈ [(6274, true), (292, false), (29, false)])))
    exact False.elim (arith_247 x (h.bound 6) g0 g1 g2)

private theorem arith_248 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : (0 : Int) ≠ (0 : Int)) (g1 : ((x 6 : Int)) = (2 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_248 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6274, true), (293, false), (29, false)] := by
  refine if hc : Holds (assignment x) [(6274, true), (293, false), (29, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6274, true) ∈ [(6274, true), (293, false), (29, false)])))
    have g1 : ((x 6 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (293, false) ∈ [(6274, true), (293, false), (29, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (29, false) ∈ [(6274, true), (293, false), (29, false)])))
    exact False.elim (arith_248 x (h.bound 6) g0 g1 g2)

private theorem arith_249 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : (0 : Int) ≠ (0 : Int)) (g1 : ((x 6 : Int)) = (3 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_249 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6274, true), (294, false), (29, false)] := by
  refine if hc : Holds (assignment x) [(6274, true), (294, false), (29, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6274, true) ∈ [(6274, true), (294, false), (29, false)])))
    have g1 : ((x 6 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (294, false) ∈ [(6274, true), (294, false), (29, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (29, false) ∈ [(6274, true), (294, false), (29, false)])))
    exact False.elim (arith_249 x (h.bound 6) g0 g1 g2)

private theorem arith_250 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : ((x 6 : Int)) = (4 : Int)) (g1 : (0 : Int) ≠ (0 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_250 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(295, false), (6274, true), (29, false)] := by
  refine if hc : Holds (assignment x) [(295, false), (6274, true), (29, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 6 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (295, false) ∈ [(295, false), (6274, true), (29, false)])))
    have g1 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6274, true) ∈ [(295, false), (6274, true), (29, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (29, false) ∈ [(295, false), (6274, true), (29, false)])))
    exact False.elim (arith_250 x (h.bound 6) g0 g1 g2)

private theorem arith_251 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : ((x 7 : Int)) = (0 : Int)) (g1 : (0 : Int) ≠ (0 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_251 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(313, false), (6284, true), (34, false)] := by
  refine if hc : Holds (assignment x) [(313, false), (6284, true), (34, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (313, false) ∈ [(313, false), (6284, true), (34, false)])))
    have g1 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6284, true) ∈ [(313, false), (6284, true), (34, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (34, false) ∈ [(313, false), (6284, true), (34, false)])))
    exact False.elim (arith_251 x (h.bound 7) g0 g1 g2)

private theorem arith_252 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : ((x 7 : Int)) = (1 : Int)) (g1 : (0 : Int) ≠ (0 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_252 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(314, false), (6284, true), (34, false)] := by
  refine if hc : Holds (assignment x) [(314, false), (6284, true), (34, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (314, false) ∈ [(314, false), (6284, true), (34, false)])))
    have g1 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6284, true) ∈ [(314, false), (6284, true), (34, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (34, false) ∈ [(314, false), (6284, true), (34, false)])))
    exact False.elim (arith_252 x (h.bound 7) g0 g1 g2)

private theorem arith_253 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : ((x 7 : Int)) = (2 : Int)) (g1 : (0 : Int) ≠ (0 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_253 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(315, false), (6284, true), (34, false)] := by
  refine if hc : Holds (assignment x) [(315, false), (6284, true), (34, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (315, false) ∈ [(315, false), (6284, true), (34, false)])))
    have g1 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6284, true) ∈ [(315, false), (6284, true), (34, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (34, false) ∈ [(315, false), (6284, true), (34, false)])))
    exact False.elim (arith_253 x (h.bound 7) g0 g1 g2)

private theorem arith_254 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : ((x 7 : Int)) = (3 : Int)) (g1 : (0 : Int) ≠ (0 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_254 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(316, false), (6284, true), (34, false)] := by
  refine if hc : Holds (assignment x) [(316, false), (6284, true), (34, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (316, false) ∈ [(316, false), (6284, true), (34, false)])))
    have g1 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6284, true) ∈ [(316, false), (6284, true), (34, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (34, false) ∈ [(316, false), (6284, true), (34, false)])))
    exact False.elim (arith_254 x (h.bound 7) g0 g1 g2)

private theorem arith_255 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : ((x 7 : Int)) = (4 : Int)) (g1 : (0 : Int) ≠ (0 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_255 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(317, false), (6284, true), (34, false)] := by
  refine if hc : Holds (assignment x) [(317, false), (6284, true), (34, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 7 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (317, false) ∈ [(317, false), (6284, true), (34, false)])))
    have g1 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6284, true) ∈ [(317, false), (6284, true), (34, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (34, false) ∈ [(317, false), (6284, true), (34, false)])))
    exact False.elim (arith_255 x (h.bound 7) g0 g1 g2)

private theorem arith_256 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) ≠ (12 : Int)) (g1 : ((x 8 : Int)) ≠ (16 : Int)) (g2 : ((x 8 : Int)) ≠ (0 : Int)) (g3 : ((x 8 : Int)) ≠ (1 : Int)) (g4 : ((x 8 : Int)) ≠ (2 : Int)) (g5 : ((x 8 : Int)) ≠ (3 : Int)) (g6 : ((x 8 : Int)) ≠ (4 : Int)) (g7 : ((x 8 : Int)) ≠ (6 : Int)) (g8 : ((x 8 : Int)) ≠ (8 : Int)) (g9 : ((x 8 : Int)) ≠ (9 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_256 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)] := by
  refine if hc : Holds (assignment x) [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6302, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g1 : ((x 8 : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6303, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g2 : ((x 8 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6294, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g3 : ((x 8 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6295, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g4 : ((x 8 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6296, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g5 : ((x 8 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6297, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g6 : ((x 8 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6298, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g7 : ((x 8 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6299, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g8 : ((x 8 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6300, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    have g9 : ((x 8 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6301, true) ∈ [(6302, true), (6303, true), (6294, true), (6295, true), (6296, true), (6297, true), (6298, true), (6299, true), (6300, true), (6301, true)])))
    exact False.elim (arith_256 x (h.bound 8) g0 g1 g2 g3 g4 g5 g6 g7 g8 g9)

private theorem arith_257 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) = (0 : Int)) (g1 : ((x 8 : Int)) ≠ (0 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_257 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(330, false), (6294, true), (40, false)] := by
  refine if hc : Holds (assignment x) [(330, false), (6294, true), (40, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (330, false) ∈ [(330, false), (6294, true), (40, false)])))
    have g1 : ((x 8 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6294, true) ∈ [(330, false), (6294, true), (40, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (40, false) ∈ [(330, false), (6294, true), (40, false)])))
    exact False.elim (arith_257 x (h.bound 8) g0 g1 g2)

private theorem arith_258 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) = (1 : Int)) (g1 : ((x 8 : Int)) ≠ (1 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_258 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(331, false), (6295, true), (40, false)] := by
  refine if hc : Holds (assignment x) [(331, false), (6295, true), (40, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (331, false) ∈ [(331, false), (6295, true), (40, false)])))
    have g1 : ((x 8 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6295, true) ∈ [(331, false), (6295, true), (40, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (40, false) ∈ [(331, false), (6295, true), (40, false)])))
    exact False.elim (arith_258 x (h.bound 8) g0 g1 g2)

private theorem arith_259 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) = (2 : Int)) (g1 : ((x 8 : Int)) ≠ (2 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_259 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(332, false), (6296, true), (40, false)] := by
  refine if hc : Holds (assignment x) [(332, false), (6296, true), (40, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (332, false) ∈ [(332, false), (6296, true), (40, false)])))
    have g1 : ((x 8 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6296, true) ∈ [(332, false), (6296, true), (40, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (40, false) ∈ [(332, false), (6296, true), (40, false)])))
    exact False.elim (arith_259 x (h.bound 8) g0 g1 g2)

private theorem arith_260 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) = (3 : Int)) (g1 : ((x 8 : Int)) ≠ (3 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_260 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(333, false), (6297, true), (40, false)] := by
  refine if hc : Holds (assignment x) [(333, false), (6297, true), (40, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (333, false) ∈ [(333, false), (6297, true), (40, false)])))
    have g1 : ((x 8 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6297, true) ∈ [(333, false), (6297, true), (40, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (40, false) ∈ [(333, false), (6297, true), (40, false)])))
    exact False.elim (arith_260 x (h.bound 8) g0 g1 g2)

private theorem arith_261 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) ≠ (4 : Int)) (g1 : ((x 8 : Int)) = (4 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_261 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6298, true), (334, false), (40, false)] := by
  refine if hc : Holds (assignment x) [(6298, true), (334, false), (40, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6298, true) ∈ [(6298, true), (334, false), (40, false)])))
    have g1 : ((x 8 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (334, false) ∈ [(6298, true), (334, false), (40, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (40, false) ∈ [(6298, true), (334, false), (40, false)])))
    exact False.elim (arith_261 x (h.bound 8) g0 g1 g2)

private theorem arith_262 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) ≠ (16 : Int)) (g1 : ((x 9 : Int)) ≠ (0 : Int)) (g2 : ((x 9 : Int)) ≠ (12 : Int)) (g3 : ((x 9 : Int)) ≠ (1 : Int)) (g4 : ((x 9 : Int)) ≠ (2 : Int)) (g5 : ((x 9 : Int)) ≠ (3 : Int)) (g6 : ((x 9 : Int)) ≠ (4 : Int)) (g7 : ((x 9 : Int)) ≠ (6 : Int)) (g8 : ((x 9 : Int)) ≠ (8 : Int)) (g9 : ((x 9 : Int)) ≠ (9 : Int)) : False := by
  rcases fiveCases (x 9) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_262 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)] := by
  refine if hc : Holds (assignment x) [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6313, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g1 : ((x 9 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6304, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g2 : ((x 9 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6312, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g3 : ((x 9 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6305, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g4 : ((x 9 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6306, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g5 : ((x 9 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6307, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g6 : ((x 9 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6308, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g7 : ((x 9 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6309, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g8 : ((x 9 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6310, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    have g9 : ((x 9 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6311, true) ∈ [(6313, true), (6304, true), (6312, true), (6305, true), (6306, true), (6307, true), (6308, true), (6309, true), (6310, true), (6311, true)])))
    exact False.elim (arith_262 x (h.bound 9) g0 g1 g2 g3 g4 g5 g6 g7 g8 g9)

private theorem arith_263 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) = (1 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 9) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_263 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6305, false), (6304, false)] := by
  refine if hc : Holds (assignment x) [(6305, false), (6304, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6305, false) ∈ [(6305, false), (6304, false)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6304, false) ∈ [(6305, false), (6304, false)])))
    exact False.elim (arith_263 x (h.bound 9) g0 g1)

private theorem arith_264 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) = (2 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 9) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_264 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6306, false), (6304, false)] := by
  refine if hc : Holds (assignment x) [(6306, false), (6304, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6306, false) ∈ [(6306, false), (6304, false)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6304, false) ∈ [(6306, false), (6304, false)])))
    exact False.elim (arith_264 x (h.bound 9) g0 g1)

private theorem arith_265 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) = (1 : Int)) (g1 : ((x 9 : Int)) ≠ (1 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 9) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_265 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(343, false), (6305, true), (45, false)] := by
  refine if hc : Holds (assignment x) [(343, false), (6305, true), (45, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (343, false) ∈ [(343, false), (6305, true), (45, false)])))
    have g1 : ((x 9 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6305, true) ∈ [(343, false), (6305, true), (45, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (45, false) ∈ [(343, false), (6305, true), (45, false)])))
    exact False.elim (arith_265 x (h.bound 9) g0 g1 g2)

private theorem arith_266 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) = (2 : Int)) (g1 : ((x 9 : Int)) ≠ (2 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 9) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_266 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(344, false), (6306, true), (45, false)] := by
  refine if hc : Holds (assignment x) [(344, false), (6306, true), (45, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (344, false) ∈ [(344, false), (6306, true), (45, false)])))
    have g1 : ((x 9 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6306, true) ∈ [(344, false), (6306, true), (45, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (45, false) ∈ [(344, false), (6306, true), (45, false)])))
    exact False.elim (arith_266 x (h.bound 9) g0 g1 g2)

private theorem arith_267 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) = (3 : Int)) (g1 : ((x 9 : Int)) ≠ (3 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 9) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_267 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(345, false), (6307, true), (45, false)] := by
  refine if hc : Holds (assignment x) [(345, false), (6307, true), (45, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (345, false) ∈ [(345, false), (6307, true), (45, false)])))
    have g1 : ((x 9 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6307, true) ∈ [(345, false), (6307, true), (45, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (45, false) ∈ [(345, false), (6307, true), (45, false)])))
    exact False.elim (arith_267 x (h.bound 9) g0 g1 g2)

private theorem arith_268 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) = (4 : Int)) (g1 : ((x 9 : Int)) ≠ (4 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 9) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_268 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(346, false), (6308, true), (45, false)] := by
  refine if hc : Holds (assignment x) [(346, false), (6308, true), (45, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (346, false) ∈ [(346, false), (6308, true), (45, false)])))
    have g1 : ((x 9 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6308, true) ∈ [(346, false), (6308, true), (45, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (45, false) ∈ [(346, false), (6308, true), (45, false)])))
    exact False.elim (arith_268 x (h.bound 9) g0 g1 g2)

private theorem arith_269 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : ((x 10 : Int)) ≠ (16 : Int)) (g1 : ((x 10 : Int)) ≠ (12 : Int)) (g2 : ((x 10 : Int)) ≠ (0 : Int)) (g3 : ((x 10 : Int)) ≠ (1 : Int)) (g4 : ((x 10 : Int)) ≠ (2 : Int)) (g5 : ((x 10 : Int)) ≠ (3 : Int)) (g6 : ((x 10 : Int)) ≠ (4 : Int)) (g7 : ((x 10 : Int)) ≠ (6 : Int)) (g8 : ((x 10 : Int)) ≠ (8 : Int)) (g9 : ((x 10 : Int)) ≠ (9 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_269 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)] := by
  refine if hc : Holds (assignment x) [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6323, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g1 : ((x 10 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6322, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g2 : ((x 10 : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6314, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g3 : ((x 10 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6315, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g4 : ((x 10 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6316, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g5 : ((x 10 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6317, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g6 : ((x 10 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6318, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g7 : ((x 10 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6319, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g8 : ((x 10 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6320, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    have g9 : ((x 10 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6321, true) ∈ [(6323, true), (6322, true), (6314, true), (6315, true), (6316, true), (6317, true), (6318, true), (6319, true), (6320, true), (6321, true)])))
    exact False.elim (arith_269 x (h.bound 10) g0 g1 g2 g3 g4 g5 g6 g7 g8 g9)

private theorem arith_270 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : ((x 10 : Int)) = (1 : Int)) (g1 : ((x 10 : Int)) ≠ (1 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_270 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(350, false), (6315, true), (50, false)] := by
  refine if hc : Holds (assignment x) [(350, false), (6315, true), (50, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (350, false) ∈ [(350, false), (6315, true), (50, false)])))
    have g1 : ((x 10 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6315, true) ∈ [(350, false), (6315, true), (50, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (50, false) ∈ [(350, false), (6315, true), (50, false)])))
    exact False.elim (arith_270 x (h.bound 10) g0 g1 g2)

private theorem arith_271 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : ((x 10 : Int)) = (2 : Int)) (g1 : ((x 10 : Int)) ≠ (2 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_271 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(351, false), (6316, true), (50, false)] := by
  refine if hc : Holds (assignment x) [(351, false), (6316, true), (50, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (351, false) ∈ [(351, false), (6316, true), (50, false)])))
    have g1 : ((x 10 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6316, true) ∈ [(351, false), (6316, true), (50, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (50, false) ∈ [(351, false), (6316, true), (50, false)])))
    exact False.elim (arith_271 x (h.bound 10) g0 g1 g2)

private theorem arith_272 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : ((x 10 : Int)) ≠ (3 : Int)) (g1 : ((x 10 : Int)) = (3 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_272 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6317, true), (352, false), (50, false)] := by
  refine if hc : Holds (assignment x) [(6317, true), (352, false), (50, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6317, true) ∈ [(6317, true), (352, false), (50, false)])))
    have g1 : ((x 10 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (352, false) ∈ [(6317, true), (352, false), (50, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (50, false) ∈ [(6317, true), (352, false), (50, false)])))
    exact False.elim (arith_272 x (h.bound 10) g0 g1 g2)

private theorem arith_273 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : ((x 10 : Int)) = (4 : Int)) (g1 : ((x 10 : Int)) ≠ (4 : Int)) (g2 : ((1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_273 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(353, false), (6318, true), (50, false)] := by
  refine if hc : Holds (assignment x) [(353, false), (6318, true), (50, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (353, false) ∈ [(353, false), (6318, true), (50, false)])))
    have g1 : ((x 10 : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6318, true) ∈ [(353, false), (6318, true), (50, false)])))
    have g2 : ((1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (50, false) ∈ [(353, false), (6318, true), (50, false)])))
    exact False.elim (arith_273 x (h.bound 10) g0 g1 g2)

private theorem arith_274 (x : Fin 12 → Nat)
    (hb : x 11 ≤ 4) (hd : x 11 = 0 ∨ x 11 = 2) (g0 : ((3 * (x 11 : Int))) ≠ (8 : Int)) (g1 : ((3 * (x 11 : Int))) ≠ (6 : Int)) (g2 : ((3 * (x 11 : Int))) ≠ (0 : Int)) (g3 : ((3 * (x 11 : Int))) ≠ (2 : Int)) (g4 : ((3 * (x 11 : Int))) ≠ (4 : Int)) : False := by
  rcases fiveCases (x 11) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_274 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6328, true), (6327, true), (6324, true), (6325, true), (6326, true)] := by
  refine if hc : Holds (assignment x) [(6328, true), (6327, true), (6324, true), (6325, true), (6326, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6328, true) ∈ [(6328, true), (6327, true), (6324, true), (6325, true), (6326, true)])))
    have g1 : ((3 * (x 11 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6327, true) ∈ [(6328, true), (6327, true), (6324, true), (6325, true), (6326, true)])))
    have g2 : ((3 * (x 11 : Int))) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6324, true) ∈ [(6328, true), (6327, true), (6324, true), (6325, true), (6326, true)])))
    have g3 : ((3 * (x 11 : Int))) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6325, true) ∈ [(6328, true), (6327, true), (6324, true), (6325, true), (6326, true)])))
    have g4 : ((3 * (x 11 : Int))) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6326, true) ∈ [(6328, true), (6327, true), (6324, true), (6325, true), (6326, true)])))
    exact False.elim (arith_274 x (h.bound 11) h.diagonal g0 g1 g2 g3 g4)

private theorem arith_275 (x : Fin 12 → Nat)
    (hb : x 11 ≤ 4) (hd : x 11 = 0 ∨ x 11 = 2) (g0 : ((3 * (x 11 : Int))) ≠ (6 : Int)) (g1 : ((x 11 : Int)) = (2 : Int)) (g2 : ((3 : Int)) = (3 : Int)) : False := by
  rcases fiveCases (x 11) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_275 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6327, true), (355, false), (57, false)] := by
  refine if hc : Holds (assignment x) [(6327, true), (355, false), (57, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6327, true) ∈ [(6327, true), (355, false), (57, false)])))
    have g1 : ((x 11 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (355, false) ∈ [(6327, true), (355, false), (57, false)])))
    have g2 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (57, false) ∈ [(6327, true), (355, false), (57, false)])))
    exact False.elim (arith_275 x (h.bound 11) h.diagonal g0 g1 g2)

private theorem arith_276 (x : Fin 12 → Nat)
    (g0 : ((6 : Int)) ≠ (6 : Int)) (g1 : ((6 : Int)) = (6 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  omega

theorem clause_276 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6332, true), (6222, false), (1, false)] := by
  refine if hc : Holds (assignment x) [(6332, true), (6222, false), (1, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6332, true) ∈ [(6332, true), (6222, false), (1, false)])))
    have g1 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6222, false) ∈ [(6332, true), (6222, false), (1, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (1, false) ∈ [(6332, true), (6222, false), (1, false)])))
    exact False.elim (arith_276 x g0 g1 g2)

private theorem arith_277 (x : Fin 12 → Nat)
    (g0 : ((6 : Int)) ≠ (6 : Int)) (g1 : (0 : Int) = (0 : Int)) (g2 : ((6 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_277 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6339, true), (6224, false), (6332, false)] := by
  refine if hc : Holds (assignment x) [(6339, true), (6224, false), (6332, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6339, true) ∈ [(6339, true), (6224, false), (6332, false)])))
    have g1 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6224, false) ∈ [(6339, true), (6224, false), (6332, false)])))
    have g2 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6332, false) ∈ [(6339, true), (6224, false), (6332, false)])))
    exact False.elim (arith_277 x g0 g1 g2)

private theorem arith_278 (x : Fin 12 → Nat)
    (g0 : ((x 2 : Int)) = (0 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) ≠ (6 : Int)) (g2 : ((6 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_278 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6234, false), (6352, true), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6234, false), (6352, true), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6234, false) ∈ [(6234, false), (6352, true), (6339, false)])))
    have g1 : ((6 : Int) + (x 2 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6352, true) ∈ [(6234, false), (6352, true), (6339, false)])))
    have g2 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6234, false), (6352, true), (6339, false)])))
    exact False.elim (arith_278 x g0 g1 g2)

private theorem arith_279 (x : Fin 12 → Nat)
    (g0 : ((x 2 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) ≠ (7 : Int)) (g2 : ((6 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_279 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6235, false), (6357, true), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6235, false), (6357, true), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6235, false) ∈ [(6235, false), (6357, true), (6339, false)])))
    have g1 : ((6 : Int) + (x 2 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6357, true) ∈ [(6235, false), (6357, true), (6339, false)])))
    have g2 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6235, false), (6357, true), (6339, false)])))
    exact False.elim (arith_279 x g0 g1 g2)

private theorem arith_280 (x : Fin 12 → Nat)
    (g0 : ((x 2 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) ≠ (8 : Int)) (g2 : ((6 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_280 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6236, false), (6353, true), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6236, false), (6353, true), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6236, false) ∈ [(6236, false), (6353, true), (6339, false)])))
    have g1 : ((6 : Int) + (x 2 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6353, true) ∈ [(6236, false), (6353, true), (6339, false)])))
    have g2 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6236, false), (6353, true), (6339, false)])))
    exact False.elim (arith_280 x g0 g1 g2)

private theorem arith_281 (x : Fin 12 → Nat)
    (g0 : ((x 2 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) ≠ (9 : Int)) (g2 : ((6 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_281 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6237, false), (6354, true), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6237, false), (6354, true), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6237, false) ∈ [(6237, false), (6354, true), (6339, false)])))
    have g1 : ((6 : Int) + (x 2 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6354, true) ∈ [(6237, false), (6354, true), (6339, false)])))
    have g2 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6237, false), (6354, true), (6339, false)])))
    exact False.elim (arith_281 x g0 g1 g2)

private theorem arith_282 (x : Fin 12 → Nat)
    (g0 : ((x 2 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) ≠ (10 : Int)) (g2 : ((6 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_282 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6238, false), (6358, true), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6238, false), (6358, true), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6238, false) ∈ [(6238, false), (6358, true), (6339, false)])))
    have g1 : ((6 : Int) + (x 2 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6358, true) ∈ [(6238, false), (6358, true), (6339, false)])))
    have g2 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6238, false), (6358, true), (6339, false)])))
    exact False.elim (arith_282 x g0 g1 g2)

private theorem arith_283 (x : Fin 12 → Nat)
    (g0 : ((x 2 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) ≠ (12 : Int)) (g2 : ((6 : Int)) = (6 : Int)) : False := by
  omega

theorem clause_283 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6239, false), (6355, true), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6239, false), (6355, true), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6239, false) ∈ [(6239, false), (6355, true), (6339, false)])))
    have g1 : ((6 : Int) + (x 2 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6355, true) ∈ [(6239, false), (6355, true), (6339, false)])))
    have g2 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6239, false), (6355, true), (6339, false)])))
    exact False.elim (arith_283 x g0 g1 g2)

private theorem arith_284 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 2 : Int)) = (8 : Int)) (g1 : ((6 : Int)) = (6 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_284 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6240, false), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6240, false), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6240, false) ∈ [(6240, false), (6339, false)])))
    have g1 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6240, false), (6339, false)])))
    exact False.elim (arith_284 x h.zero h.dot g0 g1)

private theorem arith_285 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 2 : Int)) = (9 : Int)) (g1 : ((6 : Int)) = (6 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_285 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6241, false), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6241, false), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6241, false) ∈ [(6241, false), (6339, false)])))
    have g1 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6241, false), (6339, false)])))
    exact False.elim (arith_285 x h.zero h.dot g0 g1)

private theorem arith_286 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 2 : Int)) = (12 : Int)) (g1 : ((6 : Int)) = (6 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_286 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6242, false), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6242, false), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6242, false) ∈ [(6242, false), (6339, false)])))
    have g1 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6242, false), (6339, false)])))
    exact False.elim (arith_286 x h.zero h.dot g0 g1)

private theorem arith_287 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 2 : Int)) = (16 : Int)) (g1 : ((6 : Int)) = (6 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_287 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6243, false), (6339, false)] := by
  refine if hc : Holds (assignment x) [(6243, false), (6339, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 2 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6243, false) ∈ [(6243, false), (6339, false)])))
    have g1 : ((6 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6339, false) ∈ [(6243, false), (6339, false)])))
    exact False.elim (arith_287 x h.zero h.dot g0 g1)

private theorem arith_288 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (6 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_288 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6352, false), (6365, true), (6244, false)] := by
  refine if hc : Holds (assignment x) [(6352, false), (6365, true), (6244, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6352, false) ∈ [(6352, false), (6365, true), (6244, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6365, true) ∈ [(6352, false), (6365, true), (6244, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6244, false) ∈ [(6352, false), (6365, true), (6244, false)])))
    exact False.elim (arith_288 x g0 g1 g2)

private theorem arith_289 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (7 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_289 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6352, false), (6370, true), (6245, false)] := by
  refine if hc : Holds (assignment x) [(6352, false), (6370, true), (6245, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6352, false) ∈ [(6352, false), (6370, true), (6245, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6370, true) ∈ [(6352, false), (6370, true), (6245, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6245, false) ∈ [(6352, false), (6370, true), (6245, false)])))
    exact False.elim (arith_289 x g0 g1 g2)

private theorem arith_290 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) = (6 : Int)) (g2 : ((x 3 : Int)) = (2 : Int)) : False := by
  omega

theorem clause_290 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6366, true), (6352, false), (6246, false)] := by
  refine if hc : Holds (assignment x) [(6366, true), (6352, false), (6246, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6366, true) ∈ [(6366, true), (6352, false), (6246, false)])))
    have g1 : ((6 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6352, false) ∈ [(6366, true), (6352, false), (6246, false)])))
    have g2 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6246, false) ∈ [(6366, true), (6352, false), (6246, false)])))
    exact False.elim (arith_290 x g0 g1 g2)

private theorem arith_291 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (6 : Int)) (g1 : ((x 3 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_291 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6352, false), (6247, false), (6367, true)] := by
  refine if hc : Holds (assignment x) [(6352, false), (6247, false), (6367, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6352, false) ∈ [(6352, false), (6247, false), (6367, true)])))
    have g1 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6247, false) ∈ [(6352, false), (6247, false), (6367, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6367, true) ∈ [(6352, false), (6247, false), (6367, true)])))
    exact False.elim (arith_291 x g0 g1 g2)

private theorem arith_292 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (8 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_292 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6353, false), (6366, true), (6244, false)] := by
  refine if hc : Holds (assignment x) [(6353, false), (6366, true), (6244, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6353, false) ∈ [(6353, false), (6366, true), (6244, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6366, true) ∈ [(6353, false), (6366, true), (6244, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6244, false) ∈ [(6353, false), (6366, true), (6244, false)])))
    exact False.elim (arith_292 x g0 g1 g2)

private theorem arith_293 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((x 3 : Int)) = (1 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_293 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6353, false), (6245, false), (6367, true)] := by
  refine if hc : Holds (assignment x) [(6353, false), (6245, false), (6367, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6353, false) ∈ [(6353, false), (6245, false), (6367, true)])))
    have g1 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6245, false) ∈ [(6353, false), (6245, false), (6367, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6367, true) ∈ [(6353, false), (6245, false), (6367, true)])))
    exact False.elim (arith_293 x g0 g1 g2)

private theorem arith_294 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((x 3 : Int)) = (2 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_294 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6353, false), (6246, false), (6371, true)] := by
  refine if hc : Holds (assignment x) [(6353, false), (6246, false), (6371, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6353, false) ∈ [(6353, false), (6246, false), (6371, true)])))
    have g1 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6246, false) ∈ [(6353, false), (6246, false), (6371, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6371, true) ∈ [(6353, false), (6246, false), (6371, true)])))
    exact False.elim (arith_294 x g0 g1 g2)

private theorem arith_295 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((x 3 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_295 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6353, false), (6247, false), (6372, true)] := by
  refine if hc : Holds (assignment x) [(6353, false), (6247, false), (6372, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6353, false) ∈ [(6353, false), (6247, false), (6372, true)])))
    have g1 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6247, false) ∈ [(6353, false), (6247, false), (6372, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6372, true) ∈ [(6353, false), (6247, false), (6372, true)])))
    exact False.elim (arith_295 x g0 g1 g2)

private theorem arith_296 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int)) (g1 : ((x 3 : Int)) = (4 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_296 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6353, false), (6248, false), (6368, true)] := by
  refine if hc : Holds (assignment x) [(6353, false), (6248, false), (6368, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6353, false) ∈ [(6353, false), (6248, false), (6368, true)])))
    have g1 : ((x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6248, false) ∈ [(6353, false), (6248, false), (6368, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6368, true) ∈ [(6353, false), (6248, false), (6368, true)])))
    exact False.elim (arith_296 x g0 g1 g2)

private theorem arith_297 (x : Fin 12 → Nat)
    (g0 : ((x 3 : Int)) = (0 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_297 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6244, false), (6354, false), (6367, true)] := by
  refine if hc : Holds (assignment x) [(6244, false), (6354, false), (6367, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6244, false) ∈ [(6244, false), (6354, false), (6367, true)])))
    have g1 : ((6 : Int) + (x 2 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6354, false) ∈ [(6244, false), (6354, false), (6367, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6367, true) ∈ [(6244, false), (6354, false), (6367, true)])))
    exact False.elim (arith_297 x g0 g1 g2)

private theorem arith_298 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (9 : Int)) (g1 : ((x 3 : Int)) = (1 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_298 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6354, false), (6245, false), (6371, true)] := by
  refine if hc : Holds (assignment x) [(6354, false), (6245, false), (6371, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6354, false) ∈ [(6354, false), (6245, false), (6371, true)])))
    have g1 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6245, false) ∈ [(6354, false), (6245, false), (6371, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6371, true) ∈ [(6354, false), (6245, false), (6371, true)])))
    exact False.elim (arith_298 x g0 g1 g2)

private theorem arith_299 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (9 : Int)) (g1 : ((x 3 : Int)) = (2 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_299 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6354, false), (6246, false), (6372, true)] := by
  refine if hc : Holds (assignment x) [(6354, false), (6246, false), (6372, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6354, false) ∈ [(6354, false), (6246, false), (6372, true)])))
    have g1 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6246, false) ∈ [(6354, false), (6246, false), (6372, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6372, true) ∈ [(6354, false), (6246, false), (6372, true)])))
    exact False.elim (arith_299 x g0 g1 g2)

private theorem arith_300 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (9 : Int)) (g1 : ((x 3 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_300 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6354, false), (6247, false), (6368, true)] := by
  refine if hc : Holds (assignment x) [(6354, false), (6247, false), (6368, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6354, false) ∈ [(6354, false), (6247, false), (6368, true)])))
    have g1 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6247, false) ∈ [(6354, false), (6247, false), (6368, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6368, true) ∈ [(6354, false), (6247, false), (6368, true)])))
    exact False.elim (arith_300 x g0 g1 g2)

private theorem arith_301 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int)) = (9 : Int)) (g1 : ((x 3 : Int)) = (4 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_301 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6354, false), (6248, false)] := by
  refine if hc : Holds (assignment x) [(6354, false), (6248, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6354, false) ∈ [(6354, false), (6248, false)])))
    have g1 : ((x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6248, false) ∈ [(6354, false), (6248, false)])))
    exact False.elim (arith_301 x h.zero h.dot g0 g1)

private theorem arith_302 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (12 : Int)) (g1 : ((x 3 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_302 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6355, false), (6244, false), (6368, true)] := by
  refine if hc : Holds (assignment x) [(6355, false), (6244, false), (6368, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6355, false) ∈ [(6355, false), (6244, false), (6368, true)])))
    have g1 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6244, false) ∈ [(6355, false), (6244, false), (6368, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6368, true) ∈ [(6355, false), (6244, false), (6368, true)])))
    exact False.elim (arith_302 x g0 g1 g2)

private theorem arith_303 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int)) = (12 : Int)) (g1 : ((x 3 : Int)) = (3 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_303 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6355, false), (6247, false)] := by
  refine if hc : Holds (assignment x) [(6355, false), (6247, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6355, false) ∈ [(6355, false), (6247, false)])))
    have g1 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6247, false) ∈ [(6355, false), (6247, false)])))
    exact False.elim (arith_303 x h.zero h.dot g0 g1)

private theorem arith_304 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (7 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (7 : Int)) (g2 : ((x 3 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_304 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6357, false), (6370, true), (6244, false)] := by
  refine if hc : Holds (assignment x) [(6357, false), (6370, true), (6244, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6357, false) ∈ [(6357, false), (6370, true), (6244, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6370, true) ∈ [(6357, false), (6370, true), (6244, false)])))
    have g2 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6244, false) ∈ [(6357, false), (6370, true), (6244, false)])))
    exact False.elim (arith_304 x g0 g1 g2)

private theorem arith_305 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int)) = (7 : Int)) (g2 : ((x 3 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_305 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6366, true), (6357, false), (6245, false)] := by
  refine if hc : Holds (assignment x) [(6366, true), (6357, false), (6245, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6366, true) ∈ [(6366, true), (6357, false), (6245, false)])))
    have g1 : ((6 : Int) + (x 2 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6357, false) ∈ [(6366, true), (6357, false), (6245, false)])))
    have g2 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6245, false) ∈ [(6366, true), (6357, false), (6245, false)])))
    exact False.elim (arith_305 x g0 g1 g2)

private theorem arith_306 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (7 : Int)) (g1 : ((x 3 : Int)) = (2 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_306 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6357, false), (6246, false), (6367, true)] := by
  refine if hc : Holds (assignment x) [(6357, false), (6246, false), (6367, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6357, false) ∈ [(6357, false), (6246, false), (6367, true)])))
    have g1 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6246, false) ∈ [(6357, false), (6246, false), (6367, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6367, true) ∈ [(6357, false), (6246, false), (6367, true)])))
    exact False.elim (arith_306 x g0 g1 g2)

private theorem arith_307 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (7 : Int)) (g1 : ((x 3 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_307 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6357, false), (6247, false), (6371, true)] := by
  refine if hc : Holds (assignment x) [(6357, false), (6247, false), (6371, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6357, false) ∈ [(6357, false), (6247, false), (6371, true)])))
    have g1 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6247, false) ∈ [(6357, false), (6247, false), (6371, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6371, true) ∈ [(6357, false), (6247, false), (6371, true)])))
    exact False.elim (arith_307 x g0 g1 g2)

private theorem arith_308 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int)) = (10 : Int)) (g1 : ((x 3 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_308 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6358, false), (6244, false), (6371, true)] := by
  refine if hc : Holds (assignment x) [(6358, false), (6244, false), (6371, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6358, false) ∈ [(6358, false), (6244, false), (6371, true)])))
    have g1 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6244, false) ∈ [(6358, false), (6244, false), (6371, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6371, true) ∈ [(6358, false), (6244, false), (6371, true)])))
    exact False.elim (arith_308 x g0 g1 g2)

private theorem arith_309 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int)) = (10 : Int)) (g1 : ((x 3 : Int)) = (3 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_309 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6358, false), (6247, false)] := by
  refine if hc : Holds (assignment x) [(6358, false), (6247, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6358, false) ∈ [(6358, false), (6247, false)])))
    have g1 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6247, false) ∈ [(6358, false), (6247, false)])))
    exact False.elim (arith_309 x h.zero h.dot g0 g1)

private theorem arith_310 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int)) : False := by
  omega

theorem clause_310 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6365, false), (6370, false)] := by
  refine if hc : Holds (assignment x) [(6365, false), (6370, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6365, false) ∈ [(6365, false), (6370, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6370, false) ∈ [(6365, false), (6370, false)])))
    exact False.elim (arith_310 x g0 g1)

private theorem arith_311 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_311 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6366, false), (6367, false)] := by
  refine if hc : Holds (assignment x) [(6366, false), (6367, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6366, false) ∈ [(6366, false), (6367, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6367, false) ∈ [(6366, false), (6367, false)])))
    exact False.elim (arith_311 x g0 g1)

private theorem arith_312 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int)) : False := by
  omega

theorem clause_312 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6370, false), (6366, false)] := by
  refine if hc : Holds (assignment x) [(6370, false), (6366, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6370, false) ∈ [(6370, false), (6366, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6366, false) ∈ [(6370, false), (6366, false)])))
    exact False.elim (arith_312 x g0 g1)

private theorem arith_313 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int)) : False := by
  omega

theorem clause_313 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6367, false), (6370, false)] := by
  refine if hc : Holds (assignment x) [(6367, false), (6370, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6367, false) ∈ [(6367, false), (6370, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6370, false) ∈ [(6367, false), (6370, false)])))
    exact False.elim (arith_313 x g0 g1)

private theorem arith_314 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_314 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6365, false), (6378, true), (6254, false)] := by
  refine if hc : Holds (assignment x) [(6365, false), (6378, true), (6254, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6365, false) ∈ [(6365, false), (6378, true), (6254, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6378, true) ∈ [(6365, false), (6378, true), (6254, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6365, false), (6378, true), (6254, false)])))
    exact False.elim (arith_314 x g0 g1 g2)

private theorem arith_315 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (7 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_315 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6365, false), (6383, true), (6255, false)] := by
  refine if hc : Holds (assignment x) [(6365, false), (6383, true), (6255, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6365, false) ∈ [(6365, false), (6383, true), (6255, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6383, true) ∈ [(6365, false), (6383, true), (6255, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6365, false), (6383, true), (6255, false)])))
    exact False.elim (arith_315 x g0 g1 g2)

private theorem arith_316 (x : Fin 12 → Nat)
    (g0 : ((x 4 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (8 : Int)) : False := by
  omega

theorem clause_316 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6256, false), (6365, false), (6379, true)] := by
  refine if hc : Holds (assignment x) [(6256, false), (6365, false), (6379, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6256, false) ∈ [(6256, false), (6365, false), (6379, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6365, false) ∈ [(6256, false), (6365, false), (6379, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6379, true) ∈ [(6256, false), (6365, false), (6379, true)])))
    exact False.elim (arith_316 x g0 g1 g2)

private theorem arith_317 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int)) (g1 : ((x 4 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_317 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6365, false), (6257, false), (6380, true)] := by
  refine if hc : Holds (assignment x) [(6365, false), (6257, false), (6380, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6365, false) ∈ [(6365, false), (6257, false), (6380, true)])))
    have g1 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6365, false), (6257, false), (6380, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6380, true) ∈ [(6365, false), (6257, false), (6380, true)])))
    exact False.elim (arith_317 x g0 g1 g2)

private theorem arith_318 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (8 : Int)) (g1 : ((x 4 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int)) : False := by
  omega

theorem clause_318 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6379, true), (6254, false), (6366, false)] := by
  refine if hc : Holds (assignment x) [(6379, true), (6254, false), (6366, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6379, true) ∈ [(6379, true), (6254, false), (6366, false)])))
    have g1 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6379, true), (6254, false), (6366, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6366, false) ∈ [(6379, true), (6254, false), (6366, false)])))
    exact False.elim (arith_318 x g0 g1 g2)

private theorem arith_319 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (9 : Int)) (g1 : ((x 4 : Int)) = (1 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int)) : False := by
  omega

theorem clause_319 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6380, true), (6255, false), (6366, false)] := by
  refine if hc : Holds (assignment x) [(6380, true), (6255, false), (6366, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6380, true) ∈ [(6380, true), (6255, false), (6366, false)])))
    have g1 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6380, true), (6255, false), (6366, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6366, false) ∈ [(6380, true), (6255, false), (6366, false)])))
    exact False.elim (arith_319 x g0 g1 g2)

private theorem arith_320 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int)) (g1 : ((x 4 : Int)) = (2 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_320 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6366, false), (6256, false), (6384, true)] := by
  refine if hc : Holds (assignment x) [(6366, false), (6256, false), (6384, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6366, false) ∈ [(6366, false), (6256, false), (6384, true)])))
    have g1 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6256, false) ∈ [(6366, false), (6256, false), (6384, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6384, true) ∈ [(6366, false), (6256, false), (6384, true)])))
    exact False.elim (arith_320 x g0 g1 g2)

private theorem arith_321 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int)) (g1 : ((x 4 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_321 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6366, false), (6257, false), (6385, true)] := by
  refine if hc : Holds (assignment x) [(6366, false), (6257, false), (6385, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6366, false) ∈ [(6366, false), (6257, false), (6385, true)])))
    have g1 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6366, false), (6257, false), (6385, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6385, true) ∈ [(6366, false), (6257, false), (6385, true)])))
    exact False.elim (arith_321 x g0 g1 g2)

private theorem arith_322 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (9 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_322 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6367, false), (6380, true), (6254, false)] := by
  refine if hc : Holds (assignment x) [(6367, false), (6380, true), (6254, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6367, false) ∈ [(6367, false), (6380, true), (6254, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6380, true) ∈ [(6367, false), (6380, true), (6254, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6367, false), (6380, true), (6254, false)])))
    exact False.elim (arith_322 x g0 g1 g2)

private theorem arith_323 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (10 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_323 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6367, false), (6384, true), (6255, false)] := by
  refine if hc : Holds (assignment x) [(6367, false), (6384, true), (6255, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6367, false) ∈ [(6367, false), (6384, true), (6255, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6384, true) ∈ [(6367, false), (6384, true), (6255, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6367, false), (6384, true), (6255, false)])))
    exact False.elim (arith_323 x g0 g1 g2)

private theorem arith_324 (x : Fin 12 → Nat)
    (g0 : ((x 4 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_324 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6256, false), (6367, false), (6385, true)] := by
  refine if hc : Holds (assignment x) [(6256, false), (6367, false), (6385, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6256, false) ∈ [(6256, false), (6367, false), (6385, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6367, false) ∈ [(6256, false), (6367, false), (6385, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6385, true) ∈ [(6256, false), (6367, false), (6385, true)])))
    exact False.elim (arith_324 x g0 g1 g2)

private theorem arith_325 (x : Fin 12 → Nat)
    (g0 : ((x 4 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_325 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6257, false), (6367, false), (6381, true)] := by
  refine if hc : Holds (assignment x) [(6257, false), (6367, false), (6381, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6257, false), (6367, false), (6381, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6367, false) ∈ [(6257, false), (6367, false), (6381, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6381, true) ∈ [(6257, false), (6367, false), (6381, true)])))
    exact False.elim (arith_325 x g0 g1 g2)

private theorem arith_326 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int)) (g1 : ((x 4 : Int)) = (4 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_326 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6367, false), (6258, false)] := by
  refine if hc : Holds (assignment x) [(6367, false), (6258, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6367, false) ∈ [(6367, false), (6258, false)])))
    have g1 : ((x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6258, false) ∈ [(6367, false), (6258, false)])))
    exact False.elim (arith_326 x h.zero h.dot g0 g1)

private theorem arith_327 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (12 : Int)) (g1 : ((x 4 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_327 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6381, true), (6254, false), (6368, false)] := by
  refine if hc : Holds (assignment x) [(6381, true), (6254, false), (6368, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6381, true) ∈ [(6381, true), (6254, false), (6368, false)])))
    have g1 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6381, true), (6254, false), (6368, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6368, false) ∈ [(6381, true), (6254, false), (6368, false)])))
    exact False.elim (arith_327 x g0 g1 g2)

private theorem arith_328 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 4 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_328 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6255, false), (6368, false)] := by
  refine if hc : Holds (assignment x) [(6255, false), (6368, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6255, false), (6368, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6368, false) ∈ [(6255, false), (6368, false)])))
    exact False.elim (arith_328 x h.zero h.dot g0 g1)

private theorem arith_329 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 4 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_329 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6256, false), (6368, false)] := by
  refine if hc : Holds (assignment x) [(6256, false), (6368, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6256, false) ∈ [(6256, false), (6368, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6368, false) ∈ [(6256, false), (6368, false)])))
    exact False.elim (arith_329 x h.zero h.dot g0 g1)

private theorem arith_330 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 4 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_330 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6257, false), (6368, false)] := by
  refine if hc : Holds (assignment x) [(6257, false), (6368, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6257, false), (6368, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6368, false) ∈ [(6257, false), (6368, false)])))
    exact False.elim (arith_330 x h.zero h.dot g0 g1)

private theorem arith_331 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int)) (g1 : ((x 4 : Int)) = (4 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_331 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6368, false), (6258, false)] := by
  refine if hc : Holds (assignment x) [(6368, false), (6258, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6368, false) ∈ [(6368, false), (6258, false)])))
    have g1 : ((x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6258, false) ∈ [(6368, false), (6258, false)])))
    exact False.elim (arith_331 x h.zero h.dot g0 g1)

private theorem arith_332 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (7 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_332 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6370, false), (6383, true), (6254, false)] := by
  refine if hc : Holds (assignment x) [(6370, false), (6383, true), (6254, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6370, false) ∈ [(6370, false), (6383, true), (6254, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (7 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6383, true) ∈ [(6370, false), (6383, true), (6254, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6370, false), (6383, true), (6254, false)])))
    exact False.elim (arith_332 x g0 g1 g2)

private theorem arith_333 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (8 : Int)) (g2 : ((x 4 : Int)) = (1 : Int)) : False := by
  omega

theorem clause_333 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6370, false), (6379, true), (6255, false)] := by
  refine if hc : Holds (assignment x) [(6370, false), (6379, true), (6255, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6370, false) ∈ [(6370, false), (6379, true), (6255, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6379, true) ∈ [(6370, false), (6379, true), (6255, false)])))
    have g2 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6370, false), (6379, true), (6255, false)])))
    exact False.elim (arith_333 x g0 g1 g2)

private theorem arith_334 (x : Fin 12 → Nat)
    (g0 : ((x 4 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_334 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6256, false), (6370, false), (6380, true)] := by
  refine if hc : Holds (assignment x) [(6256, false), (6370, false), (6380, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6256, false) ∈ [(6256, false), (6370, false), (6380, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6370, false) ∈ [(6256, false), (6370, false), (6380, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6380, true) ∈ [(6256, false), (6370, false), (6380, true)])))
    exact False.elim (arith_334 x g0 g1 g2)

private theorem arith_335 (x : Fin 12 → Nat)
    (g0 : ((x 4 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_335 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6257, false), (6370, false), (6384, true)] := by
  refine if hc : Holds (assignment x) [(6257, false), (6370, false), (6384, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6257, false), (6370, false), (6384, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6370, false) ∈ [(6257, false), (6370, false), (6384, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6384, true) ∈ [(6257, false), (6370, false), (6384, true)])))
    exact False.elim (arith_335 x g0 g1 g2)

private theorem arith_336 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (10 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int)) (g2 : ((x 4 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_336 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6384, true), (6371, false), (6254, false)] := by
  refine if hc : Holds (assignment x) [(6384, true), (6371, false), (6254, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6384, true) ∈ [(6384, true), (6371, false), (6254, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6371, false) ∈ [(6384, true), (6371, false), (6254, false)])))
    have g2 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6384, true), (6371, false), (6254, false)])))
    exact False.elim (arith_336 x g0 g1 g2)

private theorem arith_337 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (11 : Int)) (g1 : ((x 4 : Int)) = (1 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int)) : False := by
  omega

theorem clause_337 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6385, true), (6255, false), (6371, false)] := by
  refine if hc : Holds (assignment x) [(6385, true), (6255, false), (6371, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6385, true) ∈ [(6385, true), (6255, false), (6371, false)])))
    have g1 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6385, true), (6255, false), (6371, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6371, false) ∈ [(6385, true), (6255, false), (6371, false)])))
    exact False.elim (arith_337 x g0 g1 g2)

private theorem arith_338 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (12 : Int)) (g1 : ((x 4 : Int)) = (2 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int)) : False := by
  omega

theorem clause_338 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6381, true), (6256, false), (6371, false)] := by
  refine if hc : Holds (assignment x) [(6381, true), (6256, false), (6371, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6381, true) ∈ [(6381, true), (6256, false), (6371, false)])))
    have g1 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6256, false) ∈ [(6381, true), (6256, false), (6371, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6371, false) ∈ [(6381, true), (6256, false), (6371, false)])))
    exact False.elim (arith_338 x g0 g1 g2)

private theorem arith_339 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 4 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_339 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6257, false), (6371, false)] := by
  refine if hc : Holds (assignment x) [(6257, false), (6371, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6257, false), (6371, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6371, false) ∈ [(6257, false), (6371, false)])))
    exact False.elim (arith_339 x h.zero h.dot g0 g1)

private theorem arith_340 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int)) (g1 : ((x 4 : Int)) = (4 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_340 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6371, false), (6258, false)] := by
  refine if hc : Holds (assignment x) [(6371, false), (6258, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6371, false) ∈ [(6371, false), (6258, false)])))
    have g1 : ((x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6258, false) ∈ [(6371, false), (6258, false)])))
    exact False.elim (arith_340 x h.zero h.dot g0 g1)

private theorem arith_341 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (11 : Int)) (g1 : ((x 4 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int)) : False := by
  omega

theorem clause_341 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6385, true), (6254, false), (6372, false)] := by
  refine if hc : Holds (assignment x) [(6385, true), (6254, false), (6372, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6385, true) ∈ [(6385, true), (6254, false), (6372, false)])))
    have g1 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6254, false) ∈ [(6385, true), (6254, false), (6372, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6372, false) ∈ [(6385, true), (6254, false), (6372, false)])))
    exact False.elim (arith_341 x g0 g1 g2)

private theorem arith_342 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (12 : Int)) (g1 : ((x 4 : Int)) = (1 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int)) : False := by
  omega

theorem clause_342 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6381, true), (6255, false), (6372, false)] := by
  refine if hc : Holds (assignment x) [(6381, true), (6255, false), (6372, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6381, true) ∈ [(6381, true), (6255, false), (6372, false)])))
    have g1 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6255, false) ∈ [(6381, true), (6255, false), (6372, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6372, false) ∈ [(6381, true), (6255, false), (6372, false)])))
    exact False.elim (arith_342 x g0 g1 g2)

private theorem arith_343 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 4 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_343 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6256, false), (6372, false)] := by
  refine if hc : Holds (assignment x) [(6256, false), (6372, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6256, false) ∈ [(6256, false), (6372, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6372, false) ∈ [(6256, false), (6372, false)])))
    exact False.elim (arith_343 x h.zero h.dot g0 g1)

private theorem arith_344 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 4 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_344 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6257, false), (6372, false)] := by
  refine if hc : Holds (assignment x) [(6257, false), (6372, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6257, false) ∈ [(6257, false), (6372, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6372, false) ∈ [(6257, false), (6372, false)])))
    exact False.elim (arith_344 x h.zero h.dot g0 g1)

private theorem arith_345 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int)) (g1 : ((x 4 : Int)) = (4 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_345 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6372, false), (6258, false)] := by
  refine if hc : Holds (assignment x) [(6372, false), (6258, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6372, false) ∈ [(6372, false), (6258, false)])))
    have g1 : ((x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6258, false) ∈ [(6372, false), (6258, false)])))
    exact False.elim (arith_345 x h.zero h.dot g0 g1)

private theorem arith_346 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (6 : Int)) (g1 : ((x 5 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_346 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6378, false), (6267, false), (6393, true)] := by
  refine if hc : Holds (assignment x) [(6378, false), (6267, false), (6393, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6378, false) ∈ [(6378, false), (6267, false), (6393, true)])))
    have g1 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6267, false) ∈ [(6378, false), (6267, false), (6393, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6393, true) ∈ [(6378, false), (6267, false), (6393, true)])))
    exact False.elim (arith_346 x g0 g1 g2)

private theorem arith_347 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (6 : Int)) (g1 : ((x 5 : Int)) = (4 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_347 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6378, false), (6268, false), (6397, true)] := by
  refine if hc : Holds (assignment x) [(6378, false), (6268, false), (6397, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6378, false) ∈ [(6378, false), (6268, false), (6397, true)])))
    have g1 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6268, false) ∈ [(6378, false), (6268, false), (6397, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6397, true) ∈ [(6378, false), (6268, false), (6397, true)])))
    exact False.elim (arith_347 x g0 g1 g2)

private theorem arith_348 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_348 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6265, false), (6379, false), (6393, true)] := by
  refine if hc : Holds (assignment x) [(6265, false), (6379, false), (6393, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6265, false) ∈ [(6265, false), (6379, false), (6393, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6379, false) ∈ [(6265, false), (6379, false), (6393, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6393, true) ∈ [(6265, false), (6379, false), (6393, true)])))
    exact False.elim (arith_348 x g0 g1 g2)

private theorem arith_349 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_349 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6266, false), (6379, false), (6397, true)] := by
  refine if hc : Holds (assignment x) [(6266, false), (6379, false), (6397, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6266, false) ∈ [(6266, false), (6379, false), (6397, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6379, false) ∈ [(6266, false), (6379, false), (6397, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6397, true) ∈ [(6266, false), (6379, false), (6397, true)])))
    exact False.elim (arith_349 x g0 g1 g2)

private theorem arith_350 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int)) (g1 : ((x 5 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_350 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6379, false), (6267, false), (6398, true)] := by
  refine if hc : Holds (assignment x) [(6379, false), (6267, false), (6398, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6379, false) ∈ [(6379, false), (6267, false), (6398, true)])))
    have g1 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6267, false) ∈ [(6379, false), (6267, false), (6398, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6398, true) ∈ [(6379, false), (6267, false), (6398, true)])))
    exact False.elim (arith_350 x g0 g1 g2)

private theorem arith_351 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int)) (g1 : ((x 5 : Int)) = (4 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_351 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6379, false), (6268, false), (6394, true)] := by
  refine if hc : Holds (assignment x) [(6379, false), (6268, false), (6394, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6379, false) ∈ [(6379, false), (6268, false), (6394, true)])))
    have g1 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6268, false) ∈ [(6379, false), (6268, false), (6394, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6394, true) ∈ [(6379, false), (6268, false), (6394, true)])))
    exact False.elim (arith_351 x g0 g1 g2)

private theorem arith_352 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int)) (g2 : ((x 5 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_352 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6393, true), (6380, false), (6264, false)] := by
  refine if hc : Holds (assignment x) [(6393, true), (6380, false), (6264, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6393, true) ∈ [(6393, true), (6380, false), (6264, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6380, false) ∈ [(6393, true), (6380, false), (6264, false)])))
    have g2 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6264, false) ∈ [(6393, true), (6380, false), (6264, false)])))
    exact False.elim (arith_352 x g0 g1 g2)

private theorem arith_353 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_353 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6265, false), (6380, false), (6397, true)] := by
  refine if hc : Holds (assignment x) [(6265, false), (6380, false), (6397, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6265, false) ∈ [(6265, false), (6380, false), (6397, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6380, false) ∈ [(6265, false), (6380, false), (6397, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6397, true) ∈ [(6265, false), (6380, false), (6397, true)])))
    exact False.elim (arith_353 x g0 g1 g2)

private theorem arith_354 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_354 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6266, false), (6380, false), (6398, true)] := by
  refine if hc : Holds (assignment x) [(6266, false), (6380, false), (6398, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6266, false) ∈ [(6266, false), (6380, false), (6398, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6380, false) ∈ [(6266, false), (6380, false), (6398, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6398, true) ∈ [(6266, false), (6380, false), (6398, true)])))
    exact False.elim (arith_354 x g0 g1 g2)

private theorem arith_355 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_355 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6267, false), (6380, false), (6394, true)] := by
  refine if hc : Holds (assignment x) [(6267, false), (6380, false), (6394, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6267, false) ∈ [(6267, false), (6380, false), (6394, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6380, false) ∈ [(6267, false), (6380, false), (6394, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6394, true) ∈ [(6267, false), (6380, false), (6394, true)])))
    exact False.elim (arith_355 x g0 g1 g2)

private theorem arith_356 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_356 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6268, false), (6380, false)] := by
  refine if hc : Holds (assignment x) [(6268, false), (6380, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6268, false) ∈ [(6268, false), (6380, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6380, false) ∈ [(6268, false), (6380, false)])))
    exact False.elim (arith_356 x h.zero h.dot g0 g1)

private theorem arith_357 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int)) (g1 : ((x 5 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_357 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6394, true), (6264, false), (6381, false)] := by
  refine if hc : Holds (assignment x) [(6394, true), (6264, false), (6381, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6394, true) ∈ [(6394, true), (6264, false), (6381, false)])))
    have g1 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6264, false) ∈ [(6394, true), (6264, false), (6381, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6381, false) ∈ [(6394, true), (6264, false), (6381, false)])))
    exact False.elim (arith_357 x g0 g1 g2)

private theorem arith_358 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_358 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6265, false), (6381, false)] := by
  refine if hc : Holds (assignment x) [(6265, false), (6381, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6265, false) ∈ [(6265, false), (6381, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6381, false) ∈ [(6265, false), (6381, false)])))
    exact False.elim (arith_358 x h.zero h.dot g0 g1)

private theorem arith_359 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_359 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6266, false), (6381, false)] := by
  refine if hc : Holds (assignment x) [(6266, false), (6381, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6266, false) ∈ [(6266, false), (6381, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6381, false) ∈ [(6266, false), (6381, false)])))
    exact False.elim (arith_359 x h.zero h.dot g0 g1)

private theorem arith_360 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_360 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6267, false), (6381, false)] := by
  refine if hc : Holds (assignment x) [(6267, false), (6381, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6267, false) ∈ [(6267, false), (6381, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6381, false) ∈ [(6267, false), (6381, false)])))
    exact False.elim (arith_360 x h.zero h.dot g0 g1)

private theorem arith_361 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_361 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6268, false), (6381, false)] := by
  refine if hc : Holds (assignment x) [(6268, false), (6381, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6268, false) ∈ [(6268, false), (6381, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6381, false) ∈ [(6268, false), (6381, false)])))
    exact False.elim (arith_361 x h.zero h.dot g0 g1)

private theorem arith_362 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (7 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_362 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6266, false), (6383, false), (6393, true)] := by
  refine if hc : Holds (assignment x) [(6266, false), (6383, false), (6393, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6266, false) ∈ [(6266, false), (6383, false), (6393, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6383, false) ∈ [(6266, false), (6383, false), (6393, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6393, true) ∈ [(6266, false), (6383, false), (6393, true)])))
    exact False.elim (arith_362 x g0 g1 g2)

private theorem arith_363 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (7 : Int)) (g1 : ((x 5 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_363 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6383, false), (6267, false), (6397, true)] := by
  refine if hc : Holds (assignment x) [(6383, false), (6267, false), (6397, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6383, false) ∈ [(6383, false), (6267, false), (6397, true)])))
    have g1 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6267, false) ∈ [(6383, false), (6267, false), (6397, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6397, true) ∈ [(6383, false), (6267, false), (6397, true)])))
    exact False.elim (arith_363 x g0 g1 g2)

private theorem arith_364 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (7 : Int)) (g1 : ((x 5 : Int)) = (4 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_364 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6383, false), (6268, false), (6398, true)] := by
  refine if hc : Holds (assignment x) [(6383, false), (6268, false), (6398, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (7 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6383, false) ∈ [(6383, false), (6268, false), (6398, true)])))
    have g1 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6268, false) ∈ [(6383, false), (6268, false), (6398, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6398, true) ∈ [(6383, false), (6268, false), (6398, true)])))
    exact False.elim (arith_364 x g0 g1 g2)

private theorem arith_365 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int)) (g2 : ((x 5 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_365 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6397, true), (6384, false), (6264, false)] := by
  refine if hc : Holds (assignment x) [(6397, true), (6384, false), (6264, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6397, true) ∈ [(6397, true), (6384, false), (6264, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6384, false) ∈ [(6397, true), (6384, false), (6264, false)])))
    have g2 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6264, false) ∈ [(6397, true), (6384, false), (6264, false)])))
    exact False.elim (arith_365 x g0 g1 g2)

private theorem arith_366 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int)) : False := by
  omega

theorem clause_366 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6265, false), (6398, true), (6384, false)] := by
  refine if hc : Holds (assignment x) [(6265, false), (6398, true), (6384, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6265, false) ∈ [(6265, false), (6398, true), (6384, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6398, true) ∈ [(6265, false), (6398, true), (6384, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6384, false) ∈ [(6265, false), (6398, true), (6384, false)])))
    exact False.elim (arith_366 x g0 g1 g2)

private theorem arith_367 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int)) : False := by
  omega

theorem clause_367 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6266, false), (6394, true), (6384, false)] := by
  refine if hc : Holds (assignment x) [(6266, false), (6394, true), (6384, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6266, false) ∈ [(6266, false), (6394, true), (6384, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6394, true) ∈ [(6266, false), (6394, true), (6384, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6384, false) ∈ [(6266, false), (6394, true), (6384, false)])))
    exact False.elim (arith_367 x g0 g1 g2)

private theorem arith_368 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_368 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6267, false), (6384, false)] := by
  refine if hc : Holds (assignment x) [(6267, false), (6384, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6267, false) ∈ [(6267, false), (6384, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6384, false) ∈ [(6267, false), (6384, false)])))
    exact False.elim (arith_368 x h.zero h.dot g0 g1)

private theorem arith_369 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_369 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6268, false), (6384, false)] := by
  refine if hc : Holds (assignment x) [(6268, false), (6384, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6268, false) ∈ [(6268, false), (6384, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6384, false) ∈ [(6268, false), (6384, false)])))
    exact False.elim (arith_369 x h.zero h.dot g0 g1)

private theorem arith_370 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int)) (g2 : ((x 5 : Int)) = (0 : Int)) : False := by
  omega

theorem clause_370 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6398, true), (6385, false), (6264, false)] := by
  refine if hc : Holds (assignment x) [(6398, true), (6385, false), (6264, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6398, true) ∈ [(6398, true), (6385, false), (6264, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6385, false) ∈ [(6398, true), (6385, false), (6264, false)])))
    have g2 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6264, false) ∈ [(6398, true), (6385, false), (6264, false)])))
    exact False.elim (arith_370 x g0 g1 g2)

private theorem arith_371 (x : Fin 12 → Nat)
    (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int)) : False := by
  omega

theorem clause_371 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6265, false), (6394, true), (6385, false)] := by
  refine if hc : Holds (assignment x) [(6265, false), (6394, true), (6385, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6265, false) ∈ [(6265, false), (6394, true), (6385, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6394, true) ∈ [(6265, false), (6394, true), (6385, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6385, false) ∈ [(6265, false), (6394, true), (6385, false)])))
    exact False.elim (arith_371 x g0 g1 g2)

private theorem arith_372 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_372 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6266, false), (6385, false)] := by
  refine if hc : Holds (assignment x) [(6266, false), (6385, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6266, false) ∈ [(6266, false), (6385, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6385, false) ∈ [(6266, false), (6385, false)])))
    exact False.elim (arith_372 x h.zero h.dot g0 g1)

private theorem arith_373 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_373 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6267, false), (6385, false)] := by
  refine if hc : Holds (assignment x) [(6267, false), (6385, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6267, false) ∈ [(6267, false), (6385, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6385, false) ∈ [(6267, false), (6385, false)])))
    exact False.elim (arith_373 x h.zero h.dot g0 g1)

private theorem arith_374 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 5 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_374 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6268, false), (6385, false)] := by
  refine if hc : Holds (assignment x) [(6268, false), (6385, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6268, false) ∈ [(6268, false), (6385, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6385, false) ∈ [(6268, false), (6385, false)])))
    exact False.elim (arith_374 x h.zero h.dot g0 g1)

private theorem arith_375 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int)) (g1 : (0 : Int) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_375 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6406, true), (6274, false), (6393, false)] := by
  refine if hc : Holds (assignment x) [(6406, true), (6274, false), (6393, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6406, true) ∈ [(6406, true), (6274, false), (6393, false)])))
    have g1 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6274, false) ∈ [(6406, true), (6274, false), (6393, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6393, false) ∈ [(6406, true), (6274, false), (6393, false)])))
    exact False.elim (arith_375 x g0 g1 g2)

private theorem arith_376 (x : Fin 12 → Nat)
    (g0 : (0 : Int) = (0 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  omega

theorem clause_376 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6274, false), (6407, true), (6394, false)] := by
  refine if hc : Holds (assignment x) [(6274, false), (6407, true), (6394, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6274, false) ∈ [(6274, false), (6407, true), (6394, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6407, true) ∈ [(6274, false), (6407, true), (6394, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6394, false) ∈ [(6274, false), (6407, true), (6394, false)])))
    exact False.elim (arith_376 x g0 g1 g2)

private theorem arith_377 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int)) (g1 : (0 : Int) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_377 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6397, false), (6274, false), (6410, true)] := by
  refine if hc : Holds (assignment x) [(6397, false), (6274, false), (6410, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6397, false) ∈ [(6397, false), (6274, false), (6410, true)])))
    have g1 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6274, false) ∈ [(6397, false), (6274, false), (6410, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6410, true) ∈ [(6397, false), (6274, false), (6410, true)])))
    exact False.elim (arith_377 x g0 g1 g2)

private theorem arith_378 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) (g1 : (0 : Int) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_378 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6398, false), (6274, false), (6411, true)] := by
  refine if hc : Holds (assignment x) [(6398, false), (6274, false), (6411, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6398, false) ∈ [(6398, false), (6274, false), (6411, true)])))
    have g1 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6274, false) ∈ [(6398, false), (6274, false), (6411, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6411, true) ∈ [(6398, false), (6274, false), (6411, true)])))
    exact False.elim (arith_378 x g0 g1 g2)

private theorem arith_379 (x : Fin 12 → Nat)
    (g0 : (0 : Int) = (0 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_379 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6284, false), (6419, true), (6406, false)] := by
  refine if hc : Holds (assignment x) [(6284, false), (6419, true), (6406, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6284, false) ∈ [(6284, false), (6419, true), (6406, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6419, true) ∈ [(6284, false), (6419, true), (6406, false)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6406, false) ∈ [(6284, false), (6419, true), (6406, false)])))
    exact False.elim (arith_379 x g0 g1 g2)

private theorem arith_380 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) (g1 : (0 : Int) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_380 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6407, false), (6284, false), (6420, true)] := by
  refine if hc : Holds (assignment x) [(6407, false), (6284, false), (6420, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6407, false) ∈ [(6407, false), (6284, false), (6420, true)])))
    have g1 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6284, false) ∈ [(6407, false), (6284, false), (6420, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6420, true) ∈ [(6407, false), (6284, false), (6420, true)])))
    exact False.elim (arith_380 x g0 g1 g2)

private theorem arith_381 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int)) (g1 : (0 : Int) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_381 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6410, false), (6284, false), (6423, true)] := by
  refine if hc : Holds (assignment x) [(6410, false), (6284, false), (6423, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6410, false) ∈ [(6410, false), (6284, false), (6423, true)])))
    have g1 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6284, false) ∈ [(6410, false), (6284, false), (6423, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6423, true) ∈ [(6410, false), (6284, false), (6423, true)])))
    exact False.elim (arith_381 x g0 g1 g2)

private theorem arith_382 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) (g1 : (0 : Int) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_382 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6411, false), (6284, false), (6424, true)] := by
  refine if hc : Holds (assignment x) [(6411, false), (6284, false), (6424, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6411, false) ∈ [(6411, false), (6284, false), (6424, true)])))
    have g1 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6284, false) ∈ [(6411, false), (6284, false), (6424, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6424, true) ∈ [(6411, false), (6284, false), (6424, true)])))
    exact False.elim (arith_382 x g0 g1 g2)

private theorem arith_383 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_383 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6419, false), (6294, false), (6432, true)] := by
  refine if hc : Holds (assignment x) [(6419, false), (6294, false), (6432, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6419, false) ∈ [(6419, false), (6294, false), (6432, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6294, false) ∈ [(6419, false), (6294, false), (6432, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6432, true) ∈ [(6419, false), (6294, false), (6432, true)])))
    exact False.elim (arith_383 x g0 g1 g2)

private theorem arith_384 (x : Fin 12 → Nat)
    (g0 : ((x 8 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_384 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6295, false), (6419, false), (6436, true)] := by
  refine if hc : Holds (assignment x) [(6295, false), (6419, false), (6436, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6295, false) ∈ [(6295, false), (6419, false), (6436, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6419, false) ∈ [(6295, false), (6419, false), (6436, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6436, true) ∈ [(6295, false), (6419, false), (6436, true)])))
    exact False.elim (arith_384 x g0 g1 g2)

private theorem arith_385 (x : Fin 12 → Nat)
    (g0 : ((x 8 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_385 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6296, false), (6419, false), (6437, true)] := by
  refine if hc : Holds (assignment x) [(6296, false), (6419, false), (6437, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6296, false) ∈ [(6296, false), (6419, false), (6437, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6419, false) ∈ [(6296, false), (6419, false), (6437, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6437, true) ∈ [(6296, false), (6419, false), (6437, true)])))
    exact False.elim (arith_385 x g0 g1 g2)

private theorem arith_386 (x : Fin 12 → Nat)
    (g0 : ((x 8 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_386 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6297, false), (6419, false), (6433, true)] := by
  refine if hc : Holds (assignment x) [(6297, false), (6419, false), (6433, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6297, false) ∈ [(6297, false), (6419, false), (6433, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6419, false) ∈ [(6297, false), (6419, false), (6433, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6433, true) ∈ [(6297, false), (6419, false), (6433, true)])))
    exact False.elim (arith_386 x g0 g1 g2)

private theorem arith_387 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_387 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6298, false), (6419, false)] := by
  refine if hc : Holds (assignment x) [(6298, false), (6419, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6298, false) ∈ [(6298, false), (6419, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6419, false) ∈ [(6298, false), (6419, false)])))
    exact False.elim (arith_387 x h.zero h.dot g0 g1)

private theorem arith_388 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_388 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6420, false), (6294, false), (6433, true)] := by
  refine if hc : Holds (assignment x) [(6420, false), (6294, false), (6433, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6420, false), (6294, false), (6433, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6294, false) ∈ [(6420, false), (6294, false), (6433, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6433, true) ∈ [(6420, false), (6294, false), (6433, true)])))
    exact False.elim (arith_388 x g0 g1 g2)

private theorem arith_389 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_389 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6295, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6295, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6295, false) ∈ [(6295, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6295, false), (6420, false)])))
    exact False.elim (arith_389 x h.zero h.dot g0 g1)

private theorem arith_390 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_390 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6296, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6296, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6296, false) ∈ [(6296, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6296, false), (6420, false)])))
    exact False.elim (arith_390 x h.zero h.dot g0 g1)

private theorem arith_391 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_391 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6297, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6297, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6297, false) ∈ [(6297, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6297, false), (6420, false)])))
    exact False.elim (arith_391 x h.zero h.dot g0 g1)

private theorem arith_392 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_392 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6298, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6298, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6298, false) ∈ [(6298, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6298, false), (6420, false)])))
    exact False.elim (arith_392 x h.zero h.dot g0 g1)

private theorem arith_393 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_393 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6299, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6299, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6299, false) ∈ [(6299, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6299, false), (6420, false)])))
    exact False.elim (arith_393 x h.zero h.dot g0 g1)

private theorem arith_394 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_394 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6300, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6300, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6300, false) ∈ [(6300, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6300, false), (6420, false)])))
    exact False.elim (arith_394 x h.zero h.dot g0 g1)

private theorem arith_395 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_395 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6301, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6301, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6301, false) ∈ [(6301, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6301, false), (6420, false)])))
    exact False.elim (arith_395 x h.zero h.dot g0 g1)

private theorem arith_396 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_396 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6302, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6302, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6302, false) ∈ [(6302, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6302, false), (6420, false)])))
    exact False.elim (arith_396 x h.zero h.dot g0 g1)

private theorem arith_397 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_397 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6303, false), (6420, false)] := by
  refine if hc : Holds (assignment x) [(6303, false), (6420, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6303, false) ∈ [(6303, false), (6420, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6420, false) ∈ [(6303, false), (6420, false)])))
    exact False.elim (arith_397 x h.zero h.dot g0 g1)

private theorem arith_398 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_398 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6423, false), (6294, false), (6436, true)] := by
  refine if hc : Holds (assignment x) [(6423, false), (6294, false), (6436, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6423, false) ∈ [(6423, false), (6294, false), (6436, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6294, false) ∈ [(6423, false), (6294, false), (6436, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6436, true) ∈ [(6423, false), (6294, false), (6436, true)])))
    exact False.elim (arith_398 x g0 g1 g2)

private theorem arith_399 (x : Fin 12 → Nat)
    (g0 : ((x 8 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_399 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6295, false), (6423, false), (6437, true)] := by
  refine if hc : Holds (assignment x) [(6295, false), (6423, false), (6437, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6295, false) ∈ [(6295, false), (6423, false), (6437, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6423, false) ∈ [(6295, false), (6423, false), (6437, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6437, true) ∈ [(6295, false), (6423, false), (6437, true)])))
    exact False.elim (arith_399 x g0 g1 g2)

private theorem arith_400 (x : Fin 12 → Nat)
    (g0 : ((x 8 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_400 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6296, false), (6423, false), (6433, true)] := by
  refine if hc : Holds (assignment x) [(6296, false), (6423, false), (6433, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6296, false) ∈ [(6296, false), (6423, false), (6433, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6423, false) ∈ [(6296, false), (6423, false), (6433, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6433, true) ∈ [(6296, false), (6423, false), (6433, true)])))
    exact False.elim (arith_400 x g0 g1 g2)

private theorem arith_401 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_401 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6297, false), (6423, false)] := by
  refine if hc : Holds (assignment x) [(6297, false), (6423, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6297, false) ∈ [(6297, false), (6423, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6423, false) ∈ [(6297, false), (6423, false)])))
    exact False.elim (arith_401 x h.zero h.dot g0 g1)

private theorem arith_402 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_402 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6298, false), (6423, false)] := by
  refine if hc : Holds (assignment x) [(6298, false), (6423, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6298, false) ∈ [(6298, false), (6423, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6423, false) ∈ [(6298, false), (6423, false)])))
    exact False.elim (arith_402 x h.zero h.dot g0 g1)

private theorem arith_403 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) (g1 : ((x 8 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_403 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6424, false), (6294, false), (6437, true)] := by
  refine if hc : Holds (assignment x) [(6424, false), (6294, false), (6437, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6424, false), (6294, false), (6437, true)])))
    have g1 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6294, false) ∈ [(6424, false), (6294, false), (6437, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6437, true) ∈ [(6424, false), (6294, false), (6437, true)])))
    exact False.elim (arith_403 x g0 g1 g2)

private theorem arith_404 (x : Fin 12 → Nat)
    (g0 : ((x 8 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_404 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6295, false), (6424, false), (6433, true)] := by
  refine if hc : Holds (assignment x) [(6295, false), (6424, false), (6433, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6295, false) ∈ [(6295, false), (6424, false), (6433, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6295, false), (6424, false), (6433, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6433, true) ∈ [(6295, false), (6424, false), (6433, true)])))
    exact False.elim (arith_404 x g0 g1 g2)

private theorem arith_405 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_405 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6296, false), (6424, false)] := by
  refine if hc : Holds (assignment x) [(6296, false), (6424, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6296, false) ∈ [(6296, false), (6424, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6296, false), (6424, false)])))
    exact False.elim (arith_405 x h.zero h.dot g0 g1)

private theorem arith_406 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_406 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6297, false), (6424, false)] := by
  refine if hc : Holds (assignment x) [(6297, false), (6424, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6297, false) ∈ [(6297, false), (6424, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6297, false), (6424, false)])))
    exact False.elim (arith_406 x h.zero h.dot g0 g1)

private theorem arith_407 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_407 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6298, false), (6424, false)] := by
  refine if hc : Holds (assignment x) [(6298, false), (6424, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6298, false) ∈ [(6298, false), (6424, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6298, false), (6424, false)])))
    exact False.elim (arith_407 x h.zero h.dot g0 g1)

private theorem arith_408 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_408 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6299, false), (6424, false)] := by
  refine if hc : Holds (assignment x) [(6299, false), (6424, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6299, false) ∈ [(6299, false), (6424, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6299, false), (6424, false)])))
    exact False.elim (arith_408 x h.zero h.dot g0 g1)

private theorem arith_409 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_409 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6300, false), (6424, false)] := by
  refine if hc : Holds (assignment x) [(6300, false), (6424, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6300, false) ∈ [(6300, false), (6424, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6300, false), (6424, false)])))
    exact False.elim (arith_409 x h.zero h.dot g0 g1)

private theorem arith_410 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_410 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6301, false), (6424, false)] := by
  refine if hc : Holds (assignment x) [(6301, false), (6424, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6301, false) ∈ [(6301, false), (6424, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6301, false), (6424, false)])))
    exact False.elim (arith_410 x h.zero h.dot g0 g1)

private theorem arith_411 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_411 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6302, false), (6424, false)] := by
  refine if hc : Holds (assignment x) [(6302, false), (6424, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6302, false) ∈ [(6302, false), (6424, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6302, false), (6424, false)])))
    exact False.elim (arith_411 x h.zero h.dot g0 g1)

private theorem arith_412 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 8 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_412 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6303, false), (6424, false)] := by
  refine if hc : Holds (assignment x) [(6303, false), (6424, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6303, false) ∈ [(6303, false), (6424, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6424, false) ∈ [(6303, false), (6424, false)])))
    exact False.elim (arith_412 x h.zero h.dot g0 g1)

private theorem arith_413 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_413 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6432, false), (6304, false), (6445, true)] := by
  refine if hc : Holds (assignment x) [(6432, false), (6304, false), (6445, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6432, false), (6304, false), (6445, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6304, false) ∈ [(6432, false), (6304, false), (6445, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6445, true) ∈ [(6432, false), (6304, false), (6445, true)])))
    exact False.elim (arith_413 x g0 g1 g2)

private theorem arith_414 (x : Fin 12 → Nat)
    (g0 : ((x 9 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_414 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6305, false), (6432, false), (6449, true)] := by
  refine if hc : Holds (assignment x) [(6305, false), (6432, false), (6449, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6305, false) ∈ [(6305, false), (6432, false), (6449, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6305, false), (6432, false), (6449, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6449, true) ∈ [(6305, false), (6432, false), (6449, true)])))
    exact False.elim (arith_414 x g0 g1 g2)

private theorem arith_415 (x : Fin 12 → Nat)
    (g0 : ((x 9 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_415 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6306, false), (6432, false), (6450, true)] := by
  refine if hc : Holds (assignment x) [(6306, false), (6432, false), (6450, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6306, false) ∈ [(6306, false), (6432, false), (6450, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6306, false), (6432, false), (6450, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6450, true) ∈ [(6306, false), (6432, false), (6450, true)])))
    exact False.elim (arith_415 x g0 g1 g2)

private theorem arith_416 (x : Fin 12 → Nat)
    (g0 : ((x 9 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_416 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6307, false), (6432, false), (6446, true)] := by
  refine if hc : Holds (assignment x) [(6307, false), (6432, false), (6446, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6307, false) ∈ [(6307, false), (6432, false), (6446, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6307, false), (6432, false), (6446, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6446, true) ∈ [(6307, false), (6432, false), (6446, true)])))
    exact False.elim (arith_416 x g0 g1 g2)

private theorem arith_417 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_417 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6308, false), (6432, false)] := by
  refine if hc : Holds (assignment x) [(6308, false), (6432, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6308, false) ∈ [(6308, false), (6432, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6308, false), (6432, false)])))
    exact False.elim (arith_417 x h.zero h.dot g0 g1)

private theorem arith_418 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_418 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6309, false), (6432, false)] := by
  refine if hc : Holds (assignment x) [(6309, false), (6432, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6309, false) ∈ [(6309, false), (6432, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6309, false), (6432, false)])))
    exact False.elim (arith_418 x h.zero h.dot g0 g1)

private theorem arith_419 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_419 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6310, false), (6432, false)] := by
  refine if hc : Holds (assignment x) [(6310, false), (6432, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6310, false) ∈ [(6310, false), (6432, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6310, false), (6432, false)])))
    exact False.elim (arith_419 x h.zero h.dot g0 g1)

private theorem arith_420 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_420 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6311, false), (6432, false)] := by
  refine if hc : Holds (assignment x) [(6311, false), (6432, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6311, false) ∈ [(6311, false), (6432, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6311, false), (6432, false)])))
    exact False.elim (arith_420 x h.zero h.dot g0 g1)

private theorem arith_421 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_421 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6312, false), (6432, false)] := by
  refine if hc : Holds (assignment x) [(6312, false), (6432, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6312, false) ∈ [(6312, false), (6432, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6312, false), (6432, false)])))
    exact False.elim (arith_421 x h.zero h.dot g0 g1)

private theorem arith_422 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_422 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6313, false), (6432, false)] := by
  refine if hc : Holds (assignment x) [(6313, false), (6432, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6313, false) ∈ [(6313, false), (6432, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6432, false) ∈ [(6313, false), (6432, false)])))
    exact False.elim (arith_422 x h.zero h.dot g0 g1)

private theorem arith_423 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_423 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6433, false), (6304, false), (6446, true)] := by
  refine if hc : Holds (assignment x) [(6433, false), (6304, false), (6446, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6433, false), (6304, false), (6446, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6304, false) ∈ [(6433, false), (6304, false), (6446, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6446, true) ∈ [(6433, false), (6304, false), (6446, true)])))
    exact False.elim (arith_423 x g0 g1 g2)

private theorem arith_424 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_424 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6305, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6305, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6305, false) ∈ [(6305, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6305, false), (6433, false)])))
    exact False.elim (arith_424 x h.zero h.dot g0 g1)

private theorem arith_425 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_425 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6306, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6306, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6306, false) ∈ [(6306, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6306, false), (6433, false)])))
    exact False.elim (arith_425 x h.zero h.dot g0 g1)

private theorem arith_426 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_426 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6307, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6307, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6307, false) ∈ [(6307, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6307, false), (6433, false)])))
    exact False.elim (arith_426 x h.zero h.dot g0 g1)

private theorem arith_427 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_427 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6308, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6308, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6308, false) ∈ [(6308, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6308, false), (6433, false)])))
    exact False.elim (arith_427 x h.zero h.dot g0 g1)

private theorem arith_428 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_428 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6309, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6309, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6309, false) ∈ [(6309, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6309, false), (6433, false)])))
    exact False.elim (arith_428 x h.zero h.dot g0 g1)

private theorem arith_429 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_429 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6310, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6310, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6310, false) ∈ [(6310, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6310, false), (6433, false)])))
    exact False.elim (arith_429 x h.zero h.dot g0 g1)

private theorem arith_430 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_430 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6311, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6311, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6311, false) ∈ [(6311, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6311, false), (6433, false)])))
    exact False.elim (arith_430 x h.zero h.dot g0 g1)

private theorem arith_431 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_431 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6312, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6312, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6312, false) ∈ [(6312, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6312, false), (6433, false)])))
    exact False.elim (arith_431 x h.zero h.dot g0 g1)

private theorem arith_432 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_432 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6313, false), (6433, false)] := by
  refine if hc : Holds (assignment x) [(6313, false), (6433, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6313, false) ∈ [(6313, false), (6433, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6433, false) ∈ [(6313, false), (6433, false)])))
    exact False.elim (arith_432 x h.zero h.dot g0 g1)

private theorem arith_433 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_433 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6436, false), (6304, false), (6449, true)] := by
  refine if hc : Holds (assignment x) [(6436, false), (6304, false), (6449, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6436, false), (6304, false), (6449, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6304, false) ∈ [(6436, false), (6304, false), (6449, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6449, true) ∈ [(6436, false), (6304, false), (6449, true)])))
    exact False.elim (arith_433 x g0 g1 g2)

private theorem arith_434 (x : Fin 12 → Nat)
    (g0 : ((x 9 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_434 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6305, false), (6436, false), (6450, true)] := by
  refine if hc : Holds (assignment x) [(6305, false), (6436, false), (6450, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6305, false) ∈ [(6305, false), (6436, false), (6450, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6305, false), (6436, false), (6450, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6450, true) ∈ [(6305, false), (6436, false), (6450, true)])))
    exact False.elim (arith_434 x g0 g1 g2)

private theorem arith_435 (x : Fin 12 → Nat)
    (g0 : ((x 9 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_435 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6306, false), (6436, false), (6446, true)] := by
  refine if hc : Holds (assignment x) [(6306, false), (6436, false), (6446, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6306, false) ∈ [(6306, false), (6436, false), (6446, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6306, false), (6436, false), (6446, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6446, true) ∈ [(6306, false), (6436, false), (6446, true)])))
    exact False.elim (arith_435 x g0 g1 g2)

private theorem arith_436 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_436 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6307, false), (6436, false)] := by
  refine if hc : Holds (assignment x) [(6307, false), (6436, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6307, false) ∈ [(6307, false), (6436, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6307, false), (6436, false)])))
    exact False.elim (arith_436 x h.zero h.dot g0 g1)

private theorem arith_437 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_437 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6308, false), (6436, false)] := by
  refine if hc : Holds (assignment x) [(6308, false), (6436, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6308, false) ∈ [(6308, false), (6436, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6308, false), (6436, false)])))
    exact False.elim (arith_437 x h.zero h.dot g0 g1)

private theorem arith_438 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_438 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6309, false), (6436, false)] := by
  refine if hc : Holds (assignment x) [(6309, false), (6436, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6309, false) ∈ [(6309, false), (6436, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6309, false), (6436, false)])))
    exact False.elim (arith_438 x h.zero h.dot g0 g1)

private theorem arith_439 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_439 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6310, false), (6436, false)] := by
  refine if hc : Holds (assignment x) [(6310, false), (6436, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6310, false) ∈ [(6310, false), (6436, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6310, false), (6436, false)])))
    exact False.elim (arith_439 x h.zero h.dot g0 g1)

private theorem arith_440 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_440 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6311, false), (6436, false)] := by
  refine if hc : Holds (assignment x) [(6311, false), (6436, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6311, false) ∈ [(6311, false), (6436, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6311, false), (6436, false)])))
    exact False.elim (arith_440 x h.zero h.dot g0 g1)

private theorem arith_441 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_441 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6312, false), (6436, false)] := by
  refine if hc : Holds (assignment x) [(6312, false), (6436, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6312, false) ∈ [(6312, false), (6436, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6312, false), (6436, false)])))
    exact False.elim (arith_441 x h.zero h.dot g0 g1)

private theorem arith_442 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_442 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6313, false), (6436, false)] := by
  refine if hc : Holds (assignment x) [(6313, false), (6436, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6313, false) ∈ [(6313, false), (6436, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6436, false) ∈ [(6313, false), (6436, false)])))
    exact False.elim (arith_442 x h.zero h.dot g0 g1)

private theorem arith_443 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) (g1 : ((x 9 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_443 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6437, false), (6304, false), (6450, true)] := by
  refine if hc : Holds (assignment x) [(6437, false), (6304, false), (6450, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6437, false), (6304, false), (6450, true)])))
    have g1 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6304, false) ∈ [(6437, false), (6304, false), (6450, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6450, true) ∈ [(6437, false), (6304, false), (6450, true)])))
    exact False.elim (arith_443 x g0 g1 g2)

private theorem arith_444 (x : Fin 12 → Nat)
    (g0 : ((x 9 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_444 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6305, false), (6437, false), (6446, true)] := by
  refine if hc : Holds (assignment x) [(6305, false), (6437, false), (6446, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6305, false) ∈ [(6305, false), (6437, false), (6446, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6305, false), (6437, false), (6446, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6446, true) ∈ [(6305, false), (6437, false), (6446, true)])))
    exact False.elim (arith_444 x g0 g1 g2)

private theorem arith_445 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_445 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6306, false), (6437, false)] := by
  refine if hc : Holds (assignment x) [(6306, false), (6437, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6306, false) ∈ [(6306, false), (6437, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6306, false), (6437, false)])))
    exact False.elim (arith_445 x h.zero h.dot g0 g1)

private theorem arith_446 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (3 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_446 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6307, false), (6437, false)] := by
  refine if hc : Holds (assignment x) [(6307, false), (6437, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6307, false) ∈ [(6307, false), (6437, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6307, false), (6437, false)])))
    exact False.elim (arith_446 x h.zero h.dot g0 g1)

private theorem arith_447 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_447 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6308, false), (6437, false)] := by
  refine if hc : Holds (assignment x) [(6308, false), (6437, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6308, false) ∈ [(6308, false), (6437, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6308, false), (6437, false)])))
    exact False.elim (arith_447 x h.zero h.dot g0 g1)

private theorem arith_448 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_448 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6309, false), (6437, false)] := by
  refine if hc : Holds (assignment x) [(6309, false), (6437, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6309, false) ∈ [(6309, false), (6437, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6309, false), (6437, false)])))
    exact False.elim (arith_448 x h.zero h.dot g0 g1)

private theorem arith_449 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_449 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6310, false), (6437, false)] := by
  refine if hc : Holds (assignment x) [(6310, false), (6437, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6310, false) ∈ [(6310, false), (6437, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6310, false), (6437, false)])))
    exact False.elim (arith_449 x h.zero h.dot g0 g1)

private theorem arith_450 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_450 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6311, false), (6437, false)] := by
  refine if hc : Holds (assignment x) [(6311, false), (6437, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6311, false) ∈ [(6311, false), (6437, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6311, false), (6437, false)])))
    exact False.elim (arith_450 x h.zero h.dot g0 g1)

private theorem arith_451 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_451 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6312, false), (6437, false)] := by
  refine if hc : Holds (assignment x) [(6312, false), (6437, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6312, false) ∈ [(6312, false), (6437, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6312, false), (6437, false)])))
    exact False.elim (arith_451 x h.zero h.dot g0 g1)

private theorem arith_452 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 9 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_452 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6313, false), (6437, false)] := by
  refine if hc : Holds (assignment x) [(6313, false), (6437, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6313, false) ∈ [(6313, false), (6437, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6437, false) ∈ [(6313, false), (6437, false)])))
    exact False.elim (arith_452 x h.zero h.dot g0 g1)

private theorem arith_453 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_453 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6445, false), (6314, false), (6458, true)] := by
  refine if hc : Holds (assignment x) [(6445, false), (6314, false), (6458, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6445, false), (6314, false), (6458, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6314, false) ∈ [(6445, false), (6314, false), (6458, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6458, true) ∈ [(6445, false), (6314, false), (6458, true)])))
    exact False.elim (arith_453 x g0 g1 g2)

private theorem arith_454 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_454 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6315, false), (6445, false), (6462, true)] := by
  refine if hc : Holds (assignment x) [(6315, false), (6445, false), (6462, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6315, false) ∈ [(6315, false), (6445, false), (6462, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6315, false), (6445, false), (6462, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6462, true) ∈ [(6315, false), (6445, false), (6462, true)])))
    exact False.elim (arith_454 x g0 g1 g2)

private theorem arith_455 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_455 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6316, false), (6445, false), (6463, true)] := by
  refine if hc : Holds (assignment x) [(6316, false), (6445, false), (6463, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6316, false) ∈ [(6316, false), (6445, false), (6463, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6316, false), (6445, false), (6463, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6463, true) ∈ [(6316, false), (6445, false), (6463, true)])))
    exact False.elim (arith_455 x g0 g1 g2)

private theorem arith_456 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) (g1 : ((x 10 : Int)) = (3 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_456 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6445, false), (6317, false), (6459, true)] := by
  refine if hc : Holds (assignment x) [(6445, false), (6317, false), (6459, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6445, false), (6317, false), (6459, true)])))
    have g1 : ((x 10 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6317, false) ∈ [(6445, false), (6317, false), (6459, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6459, true) ∈ [(6445, false), (6317, false), (6459, true)])))
    exact False.elim (arith_456 x g0 g1 g2)

private theorem arith_457 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_457 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6318, false), (6445, false)] := by
  refine if hc : Holds (assignment x) [(6318, false), (6445, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6318, false) ∈ [(6318, false), (6445, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6318, false), (6445, false)])))
    exact False.elim (arith_457 x h.zero h.dot g0 g1)

private theorem arith_458 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_458 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6319, false), (6445, false)] := by
  refine if hc : Holds (assignment x) [(6319, false), (6445, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6319, false) ∈ [(6319, false), (6445, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6319, false), (6445, false)])))
    exact False.elim (arith_458 x h.zero h.dot g0 g1)

private theorem arith_459 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_459 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6320, false), (6445, false)] := by
  refine if hc : Holds (assignment x) [(6320, false), (6445, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6320, false) ∈ [(6320, false), (6445, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6320, false), (6445, false)])))
    exact False.elim (arith_459 x h.zero h.dot g0 g1)

private theorem arith_460 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_460 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6321, false), (6445, false)] := by
  refine if hc : Holds (assignment x) [(6321, false), (6445, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6321, false) ∈ [(6321, false), (6445, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6321, false), (6445, false)])))
    exact False.elim (arith_460 x h.zero h.dot g0 g1)

private theorem arith_461 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_461 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6322, false), (6445, false)] := by
  refine if hc : Holds (assignment x) [(6322, false), (6445, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6322, false) ∈ [(6322, false), (6445, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6322, false), (6445, false)])))
    exact False.elim (arith_461 x h.zero h.dot g0 g1)

private theorem arith_462 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_462 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6323, false), (6445, false)] := by
  refine if hc : Holds (assignment x) [(6323, false), (6445, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6323, false) ∈ [(6323, false), (6445, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6445, false) ∈ [(6323, false), (6445, false)])))
    exact False.elim (arith_462 x h.zero h.dot g0 g1)

private theorem arith_463 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_463 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6446, false), (6314, false), (6459, true)] := by
  refine if hc : Holds (assignment x) [(6446, false), (6314, false), (6459, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6446, false), (6314, false), (6459, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6314, false) ∈ [(6446, false), (6314, false), (6459, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6459, true) ∈ [(6446, false), (6314, false), (6459, true)])))
    exact False.elim (arith_463 x g0 g1 g2)

private theorem arith_464 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_464 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6315, false), (6446, false)] := by
  refine if hc : Holds (assignment x) [(6315, false), (6446, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6315, false) ∈ [(6315, false), (6446, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6315, false), (6446, false)])))
    exact False.elim (arith_464 x h.zero h.dot g0 g1)

private theorem arith_465 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_465 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6316, false), (6446, false)] := by
  refine if hc : Holds (assignment x) [(6316, false), (6446, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6316, false) ∈ [(6316, false), (6446, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6316, false), (6446, false)])))
    exact False.elim (arith_465 x h.zero h.dot g0 g1)

private theorem arith_466 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) (g1 : ((x 10 : Int)) = (3 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_466 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6446, false), (6317, false)] := by
  refine if hc : Holds (assignment x) [(6446, false), (6317, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6446, false), (6317, false)])))
    have g1 : ((x 10 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6317, false) ∈ [(6446, false), (6317, false)])))
    exact False.elim (arith_466 x h.zero h.dot g0 g1)

private theorem arith_467 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_467 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6318, false), (6446, false)] := by
  refine if hc : Holds (assignment x) [(6318, false), (6446, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6318, false) ∈ [(6318, false), (6446, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6318, false), (6446, false)])))
    exact False.elim (arith_467 x h.zero h.dot g0 g1)

private theorem arith_468 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_468 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6319, false), (6446, false)] := by
  refine if hc : Holds (assignment x) [(6319, false), (6446, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6319, false) ∈ [(6319, false), (6446, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6319, false), (6446, false)])))
    exact False.elim (arith_468 x h.zero h.dot g0 g1)

private theorem arith_469 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_469 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6320, false), (6446, false)] := by
  refine if hc : Holds (assignment x) [(6320, false), (6446, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6320, false) ∈ [(6320, false), (6446, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6320, false), (6446, false)])))
    exact False.elim (arith_469 x h.zero h.dot g0 g1)

private theorem arith_470 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_470 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6321, false), (6446, false)] := by
  refine if hc : Holds (assignment x) [(6321, false), (6446, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6321, false) ∈ [(6321, false), (6446, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6321, false), (6446, false)])))
    exact False.elim (arith_470 x h.zero h.dot g0 g1)

private theorem arith_471 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_471 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6322, false), (6446, false)] := by
  refine if hc : Holds (assignment x) [(6322, false), (6446, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6322, false) ∈ [(6322, false), (6446, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6322, false), (6446, false)])))
    exact False.elim (arith_471 x h.zero h.dot g0 g1)

private theorem arith_472 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_472 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6323, false), (6446, false)] := by
  refine if hc : Holds (assignment x) [(6323, false), (6446, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6323, false) ∈ [(6323, false), (6446, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6446, false) ∈ [(6323, false), (6446, false)])))
    exact False.elim (arith_472 x h.zero h.dot g0 g1)

private theorem arith_473 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_473 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6449, false), (6314, false), (6462, true)] := by
  refine if hc : Holds (assignment x) [(6449, false), (6314, false), (6462, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6449, false), (6314, false), (6462, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6314, false) ∈ [(6449, false), (6314, false), (6462, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6462, true) ∈ [(6449, false), (6314, false), (6462, true)])))
    exact False.elim (arith_473 x g0 g1 g2)

private theorem arith_474 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_474 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6315, false), (6449, false), (6463, true)] := by
  refine if hc : Holds (assignment x) [(6315, false), (6449, false), (6463, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6315, false) ∈ [(6315, false), (6449, false), (6463, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6315, false), (6449, false), (6463, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6463, true) ∈ [(6315, false), (6449, false), (6463, true)])))
    exact False.elim (arith_474 x g0 g1 g2)

private theorem arith_475 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_475 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6316, false), (6449, false), (6459, true)] := by
  refine if hc : Holds (assignment x) [(6316, false), (6449, false), (6459, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6316, false) ∈ [(6316, false), (6449, false), (6459, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6316, false), (6449, false), (6459, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6459, true) ∈ [(6316, false), (6449, false), (6459, true)])))
    exact False.elim (arith_475 x g0 g1 g2)

private theorem arith_476 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) (g1 : ((x 10 : Int)) = (3 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_476 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6449, false), (6317, false)] := by
  refine if hc : Holds (assignment x) [(6449, false), (6317, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6449, false), (6317, false)])))
    have g1 : ((x 10 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6317, false) ∈ [(6449, false), (6317, false)])))
    exact False.elim (arith_476 x h.zero h.dot g0 g1)

private theorem arith_477 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_477 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6318, false), (6449, false)] := by
  refine if hc : Holds (assignment x) [(6318, false), (6449, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6318, false) ∈ [(6318, false), (6449, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6318, false), (6449, false)])))
    exact False.elim (arith_477 x h.zero h.dot g0 g1)

private theorem arith_478 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_478 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6319, false), (6449, false)] := by
  refine if hc : Holds (assignment x) [(6319, false), (6449, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6319, false) ∈ [(6319, false), (6449, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6319, false), (6449, false)])))
    exact False.elim (arith_478 x h.zero h.dot g0 g1)

private theorem arith_479 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_479 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6320, false), (6449, false)] := by
  refine if hc : Holds (assignment x) [(6320, false), (6449, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6320, false) ∈ [(6320, false), (6449, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6320, false), (6449, false)])))
    exact False.elim (arith_479 x h.zero h.dot g0 g1)

private theorem arith_480 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_480 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6321, false), (6449, false)] := by
  refine if hc : Holds (assignment x) [(6321, false), (6449, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6321, false) ∈ [(6321, false), (6449, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6321, false), (6449, false)])))
    exact False.elim (arith_480 x h.zero h.dot g0 g1)

private theorem arith_481 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_481 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6322, false), (6449, false)] := by
  refine if hc : Holds (assignment x) [(6322, false), (6449, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6322, false) ∈ [(6322, false), (6449, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6322, false), (6449, false)])))
    exact False.elim (arith_481 x h.zero h.dot g0 g1)

private theorem arith_482 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_482 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6323, false), (6449, false)] := by
  refine if hc : Holds (assignment x) [(6323, false), (6449, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6323, false) ∈ [(6323, false), (6449, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6449, false) ∈ [(6323, false), (6449, false)])))
    exact False.elim (arith_482 x h.zero h.dot g0 g1)

private theorem arith_483 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) (g1 : ((x 10 : Int)) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_483 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6450, false), (6314, false), (6463, true)] := by
  refine if hc : Holds (assignment x) [(6450, false), (6314, false), (6463, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6450, false), (6314, false), (6463, true)])))
    have g1 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6314, false) ∈ [(6450, false), (6314, false), (6463, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6463, true) ∈ [(6450, false), (6314, false), (6463, true)])))
    exact False.elim (arith_483 x g0 g1 g2)

private theorem arith_484 (x : Fin 12 → Nat)
    (g0 : ((x 10 : Int)) = (1 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_484 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6315, false), (6450, false), (6459, true)] := by
  refine if hc : Holds (assignment x) [(6315, false), (6450, false), (6459, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6315, false) ∈ [(6315, false), (6450, false), (6459, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6315, false), (6450, false), (6459, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6459, true) ∈ [(6315, false), (6450, false), (6459, true)])))
    exact False.elim (arith_484 x g0 g1 g2)

private theorem arith_485 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_485 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6316, false), (6450, false)] := by
  refine if hc : Holds (assignment x) [(6316, false), (6450, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6316, false) ∈ [(6316, false), (6450, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6316, false), (6450, false)])))
    exact False.elim (arith_485 x h.zero h.dot g0 g1)

private theorem arith_486 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) (g1 : ((x 10 : Int)) = (3 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_486 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6450, false), (6317, false)] := by
  refine if hc : Holds (assignment x) [(6450, false), (6317, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6450, false), (6317, false)])))
    have g1 : ((x 10 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6317, false) ∈ [(6450, false), (6317, false)])))
    exact False.elim (arith_486 x h.zero h.dot g0 g1)

private theorem arith_487 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_487 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6318, false), (6450, false)] := by
  refine if hc : Holds (assignment x) [(6318, false), (6450, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6318, false) ∈ [(6318, false), (6450, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6318, false), (6450, false)])))
    exact False.elim (arith_487 x h.zero h.dot g0 g1)

private theorem arith_488 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (6 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_488 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6319, false), (6450, false)] := by
  refine if hc : Holds (assignment x) [(6319, false), (6450, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6319, false) ∈ [(6319, false), (6450, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6319, false), (6450, false)])))
    exact False.elim (arith_488 x h.zero h.dot g0 g1)

private theorem arith_489 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_489 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6320, false), (6450, false)] := by
  refine if hc : Holds (assignment x) [(6320, false), (6450, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6320, false) ∈ [(6320, false), (6450, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6320, false), (6450, false)])))
    exact False.elim (arith_489 x h.zero h.dot g0 g1)

private theorem arith_490 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (9 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_490 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6321, false), (6450, false)] := by
  refine if hc : Holds (assignment x) [(6321, false), (6450, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6321, false) ∈ [(6321, false), (6450, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6321, false), (6450, false)])))
    exact False.elim (arith_490 x h.zero h.dot g0 g1)

private theorem arith_491 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (12 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_491 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6322, false), (6450, false)] := by
  refine if hc : Holds (assignment x) [(6322, false), (6450, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6322, false) ∈ [(6322, false), (6450, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6322, false), (6450, false)])))
    exact False.elim (arith_491 x h.zero h.dot g0 g1)

private theorem arith_492 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((x 10 : Int)) = (16 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_492 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6323, false), (6450, false)] := by
  refine if hc : Holds (assignment x) [(6323, false), (6450, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6323, false) ∈ [(6323, false), (6450, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6450, false) ∈ [(6323, false), (6450, false)])))
    exact False.elim (arith_492 x h.zero h.dot g0 g1)

private theorem arith_493 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (9 : Int)) (g1 : ((3 * (x 11 : Int))) = (6 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_493 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6458, false), (6327, false)] := by
  refine if hc : Holds (assignment x) [(6458, false), (6327, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6458, false) ∈ [(6458, false), (6327, false)])))
    have g1 : ((3 * (x 11 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6327, false) ∈ [(6458, false), (6327, false)])))
    exact False.elim (arith_493 x h.zero h.dot g0 g1)

private theorem arith_494 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int)) (g1 : ((3 * (x 11 : Int))) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) ≠ (12 : Int)) : False := by
  omega

theorem clause_494 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6459, false), (6324, false), (6476, true)] := by
  refine if hc : Holds (assignment x) [(6459, false), (6324, false), (6476, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6459, false) ∈ [(6459, false), (6324, false), (6476, true)])))
    have g1 : ((3 * (x 11 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6324, false) ∈ [(6459, false), (6324, false), (6476, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6476, true) ∈ [(6459, false), (6324, false), (6476, true)])))
    exact False.elim (arith_494 x g0 g1 g2)

private theorem arith_495 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((3 * (x 11 : Int))) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_495 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6325, false), (6459, false)] := by
  refine if hc : Holds (assignment x) [(6325, false), (6459, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6325, false) ∈ [(6325, false), (6459, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6459, false) ∈ [(6325, false), (6459, false)])))
    exact False.elim (arith_495 x h.zero h.dot g0 g1)

private theorem arith_496 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((3 * (x 11 : Int))) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_496 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6326, false), (6459, false)] := by
  refine if hc : Holds (assignment x) [(6326, false), (6459, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6326, false) ∈ [(6326, false), (6459, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6459, false) ∈ [(6326, false), (6459, false)])))
    exact False.elim (arith_496 x h.zero h.dot g0 g1)

private theorem arith_497 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int)) (g1 : ((3 * (x 11 : Int))) = (6 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_497 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6459, false), (6327, false)] := by
  refine if hc : Holds (assignment x) [(6459, false), (6327, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6459, false) ∈ [(6459, false), (6327, false)])))
    have g1 : ((3 * (x 11 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6327, false) ∈ [(6459, false), (6327, false)])))
    exact False.elim (arith_497 x h.zero h.dot g0 g1)

private theorem arith_498 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((3 * (x 11 : Int))) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_498 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6328, false), (6459, false)] := by
  refine if hc : Holds (assignment x) [(6328, false), (6459, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6328, false) ∈ [(6328, false), (6459, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6459, false) ∈ [(6328, false), (6459, false)])))
    exact False.elim (arith_498 x h.zero h.dot g0 g1)

private theorem arith_499 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int)) (g1 : ((3 * (x 11 : Int))) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) ≠ (10 : Int)) : False := by
  omega

theorem clause_499 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6462, false), (6324, false), (6474, true)] := by
  refine if hc : Holds (assignment x) [(6462, false), (6324, false), (6474, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6462, false) ∈ [(6462, false), (6324, false), (6474, true)])))
    have g1 : ((3 * (x 11 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6324, false) ∈ [(6462, false), (6324, false), (6474, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6474, true) ∈ [(6462, false), (6324, false), (6474, true)])))
    exact False.elim (arith_499 x g0 g1 g2)

private theorem arith_500 (x : Fin 12 → Nat)
    (g0 : ((3 * (x 11 : Int))) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) ≠ (12 : Int)) : False := by
  omega

theorem clause_500 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6325, false), (6462, false), (6476, true)] := by
  refine if hc : Holds (assignment x) [(6325, false), (6462, false), (6476, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6325, false) ∈ [(6325, false), (6462, false), (6476, true)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6462, false) ∈ [(6325, false), (6462, false), (6476, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6476, true) ∈ [(6325, false), (6462, false), (6476, true)])))
    exact False.elim (arith_500 x g0 g1 g2)

private theorem arith_501 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((3 * (x 11 : Int))) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_501 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6326, false), (6462, false)] := by
  refine if hc : Holds (assignment x) [(6326, false), (6462, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6326, false) ∈ [(6326, false), (6462, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6462, false) ∈ [(6326, false), (6462, false)])))
    exact False.elim (arith_501 x h.zero h.dot g0 g1)

private theorem arith_502 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int)) (g1 : ((3 * (x 11 : Int))) = (6 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_502 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6462, false), (6327, false)] := by
  refine if hc : Holds (assignment x) [(6462, false), (6327, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6462, false) ∈ [(6462, false), (6327, false)])))
    have g1 : ((3 * (x 11 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6327, false) ∈ [(6462, false), (6327, false)])))
    exact False.elim (arith_502 x h.zero h.dot g0 g1)

private theorem arith_503 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((3 * (x 11 : Int))) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_503 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6328, false), (6462, false)] := by
  refine if hc : Holds (assignment x) [(6328, false), (6462, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6328, false) ∈ [(6328, false), (6462, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6462, false) ∈ [(6328, false), (6462, false)])))
    exact False.elim (arith_503 x h.zero h.dot g0 g1)

private theorem arith_504 (x : Fin 12 → Nat)
    (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int)) (g1 : ((3 * (x 11 : Int))) = (0 : Int)) (g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) ≠ (11 : Int)) : False := by
  omega

theorem clause_504 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6463, false), (6324, false), (6475, true)] := by
  refine if hc : Holds (assignment x) [(6463, false), (6324, false), (6475, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6463, false) ∈ [(6463, false), (6324, false), (6475, true)])))
    have g1 : ((3 * (x 11 : Int))) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6324, false) ∈ [(6463, false), (6324, false), (6475, true)])))
    have g2 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (6475, true) ∈ [(6463, false), (6324, false), (6475, true)])))
    exact False.elim (arith_504 x g0 g1 g2)

private theorem arith_505 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((3 * (x 11 : Int))) = (2 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_505 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6325, false), (6463, false)] := by
  refine if hc : Holds (assignment x) [(6325, false), (6463, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6325, false) ∈ [(6325, false), (6463, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6463, false) ∈ [(6325, false), (6463, false)])))
    exact False.elim (arith_505 x h.zero h.dot g0 g1)

private theorem arith_506 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((3 * (x 11 : Int))) = (4 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_506 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6326, false), (6463, false)] := by
  refine if hc : Holds (assignment x) [(6326, false), (6463, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6326, false) ∈ [(6326, false), (6463, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6463, false) ∈ [(6326, false), (6463, false)])))
    exact False.elim (arith_506 x h.zero h.dot g0 g1)

private theorem arith_507 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int)) (g1 : ((3 * (x 11 : Int))) = (6 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_507 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6463, false), (6327, false)] := by
  refine if hc : Holds (assignment x) [(6463, false), (6327, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6463, false) ∈ [(6463, false), (6327, false)])))
    have g1 : ((3 * (x 11 : Int))) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6327, false) ∈ [(6463, false), (6327, false)])))
    exact False.elim (arith_507 x h.zero h.dot g0 g1)

private theorem arith_508 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((3 * (x 11 : Int))) = (8 : Int)) (g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_508 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6328, false), (6463, false)] := by
  refine if hc : Holds (assignment x) [(6328, false), (6463, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 * (x 11 : Int))) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6328, false) ∈ [(6328, false), (6463, false)])))
    have g1 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6463, false) ∈ [(6328, false), (6463, false)])))
    exact False.elim (arith_508 x h.zero h.dot g0 g1)

private theorem arith_509 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (10 : Int)) (g1 : ((3 : Int)) = (3 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_509 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6474, false), (57, false)] := by
  refine if hc : Holds (assignment x) [(6474, false), (57, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6474, false) ∈ [(6474, false), (57, false)])))
    have g1 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (57, false) ∈ [(6474, false), (57, false)])))
    exact False.elim (arith_509 x h.zero h.dot g0 g1)

private theorem arith_510 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (11 : Int)) (g1 : ((3 : Int)) = (3 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_510 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6475, false), (57, false)] := by
  refine if hc : Holds (assignment x) [(6475, false), (57, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6475, false) ∈ [(6475, false), (57, false)])))
    have g1 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (57, false) ∈ [(6475, false), (57, false)])))
    exact False.elim (arith_510 x h.zero h.dot g0 g1)

private theorem arith_511 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : 2*x 0+x 2+x 3+x 4+x 5+x 8+x 9+x 10+3*x 11+3 = 12) (g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (12 : Int)) (g1 : ((3 : Int)) = (3 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_511 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(6476, false), (57, false)] := by
  refine if hc : Holds (assignment x) [(6476, false), (57, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((6 : Int) + (x 2 : Int) + (x 3 : Int) + (x 4 : Int) + (x 5 : Int) + (x 8 : Int) + (x 9 : Int) + (x 10 : Int) + (3 * (x 11 : Int))) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (6476, false) ∈ [(6476, false), (57, false)])))
    have g1 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (57, false) ∈ [(6476, false), (57, false)])))
    exact False.elim (arith_511 x h.zero h.dot g0 g1)

private theorem arith_512 (x : Fin 12 → Nat)
    (hb : x 0 ≤ 4) (g0 : ((9 : Int)) ≠ (9 : Int)) (g1 : ((3 : Int)) = (3 : Int)) : False := by
  rcases fiveCases (x 0) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_512 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25753, true), (57, false)] := by
  refine if hc : Holds (assignment x) [(25753, true), (57, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25753, true) ∈ [(25753, true), (57, false)])))
    have g1 : ((3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (57, false) ∈ [(25753, true), (57, false)])))
    exact False.elim (arith_512 x (h.bound 0) g0 g1)

private theorem arith_513 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : (((x 1 * x 1 : Nat) : Int)) ≠ (4 : Int)) (g1 : (((x 1 * x 1 : Nat) : Int)) ≠ (8 : Int)) (g2 : (((x 1 * x 1 : Nat) : Int)) ≠ (12 : Int)) (g3 : (((x 1 * x 1 : Nat) : Int)) ≠ (2 : Int)) (g4 : (((x 1 * x 1 : Nat) : Int)) ≠ (3 : Int)) (g5 : (((x 1 * x 1 : Nat) : Int)) ≠ (0 : Int)) (g6 : (((x 1 * x 1 : Nat) : Int)) ≠ (1 : Int)) (g7 : (((x 1 * x 1 : Nat) : Int)) ≠ (9 : Int)) (g8 : (((x 1 * x 1 : Nat) : Int)) ≠ (6 : Int)) (g9 : (((x 1 * x 1 : Nat) : Int)) ≠ (16 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_513 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)] := by
  refine if hc : Holds (assignment x) [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25760, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g1 : (((x 1 * x 1 : Nat) : Int)) ≠ (8 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25762, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g2 : (((x 1 * x 1 : Nat) : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25764, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g3 : (((x 1 * x 1 : Nat) : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25758, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g4 : (((x 1 * x 1 : Nat) : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25759, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g5 : (((x 1 * x 1 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25756, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g6 : (((x 1 * x 1 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25757, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g7 : (((x 1 * x 1 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25763, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g8 : (((x 1 * x 1 : Nat) : Int)) ≠ (6 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25761, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    have g9 : (((x 1 * x 1 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25765, true) ∈ [(25760, true), (25762, true), (25764, true), (25758, true), (25759, true), (25756, true), (25757, true), (25763, true), (25761, true), (25765, true)])))
    exact False.elim (arith_513 x (h.bound 1) g0 g1 g2 g3 g4 g5 g6 g7 g8 g9)

private theorem arith_514 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : (((x 1 * x 1 : Nat) : Int)) ≠ (0 : Int)) (g1 : ((x 1 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_514 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25756, true), (106, false)] := by
  refine if hc : Holds (assignment x) [(25756, true), (106, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25756, true) ∈ [(25756, true), (106, false)])))
    have g1 : ((x 1 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (106, false) ∈ [(25756, true), (106, false)])))
    exact False.elim (arith_514 x (h.bound 1) g0 g1)

private theorem arith_515 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : (((x 1 * x 1 : Nat) : Int)) ≠ (1 : Int)) (g1 : ((x 1 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_515 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25757, true), (107, false)] := by
  refine if hc : Holds (assignment x) [(25757, true), (107, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25757, true) ∈ [(25757, true), (107, false)])))
    have g1 : ((x 1 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (107, false) ∈ [(25757, true), (107, false)])))
    exact False.elim (arith_515 x (h.bound 1) g0 g1)

private theorem arith_516 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : ((x 1 : Int)) = (2 : Int)) (g1 : (((x 1 * x 1 : Nat) : Int)) ≠ (4 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_516 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(108, false), (25760, true)] := by
  refine if hc : Holds (assignment x) [(108, false), (25760, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 1 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (108, false) ∈ [(108, false), (25760, true)])))
    have g1 : (((x 1 * x 1 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25760, true) ∈ [(108, false), (25760, true)])))
    exact False.elim (arith_516 x (h.bound 1) g0 g1)

private theorem arith_517 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : (((x 1 * x 1 : Nat) : Int)) ≠ (9 : Int)) (g1 : ((x 1 : Int)) = (3 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_517 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25763, true), (109, false)] := by
  refine if hc : Holds (assignment x) [(25763, true), (109, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25763, true) ∈ [(25763, true), (109, false)])))
    have g1 : ((x 1 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (109, false) ∈ [(25763, true), (109, false)])))
    exact False.elim (arith_517 x (h.bound 1) g0 g1)

private theorem arith_518 (x : Fin 12 → Nat)
    (hb : x 1 ≤ 4) (g0 : ((x 1 : Int)) = (4 : Int)) (g1 : (((x 1 * x 1 : Nat) : Int)) ≠ (16 : Int)) : False := by
  rcases fiveCases (x 1) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_518 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(110, false), (25765, true)] := by
  refine if hc : Holds (assignment x) [(110, false), (25765, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 1 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (110, false) ∈ [(110, false), (25765, true)])))
    have g1 : (((x 1 * x 1 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25765, true) ∈ [(110, false), (25765, true)])))
    exact False.elim (arith_518 x (h.bound 1) g0 g1)

private theorem arith_519 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : (((x 2 * x 2 : Nat) : Int)) ≠ (0 : Int)) (g1 : ((x 2 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_519 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25766, true), (153, false)] := by
  refine if hc : Holds (assignment x) [(25766, true), (153, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25766, true) ∈ [(25766, true), (153, false)])))
    have g1 : ((x 2 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (153, false) ∈ [(25766, true), (153, false)])))
    exact False.elim (arith_519 x (h.bound 2) g0 g1)

private theorem arith_520 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : (((x 2 * x 2 : Nat) : Int)) ≠ (1 : Int)) (g1 : ((x 2 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_520 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25767, true), (154, false)] := by
  refine if hc : Holds (assignment x) [(25767, true), (154, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25767, true) ∈ [(25767, true), (154, false)])))
    have g1 : ((x 2 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (154, false) ∈ [(25767, true), (154, false)])))
    exact False.elim (arith_520 x (h.bound 2) g0 g1)

private theorem arith_521 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : (((x 2 * x 2 : Nat) : Int)) ≠ (4 : Int)) (g1 : ((x 2 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_521 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25770, true), (155, false)] := by
  refine if hc : Holds (assignment x) [(25770, true), (155, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25770, true) ∈ [(25770, true), (155, false)])))
    have g1 : ((x 2 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (155, false) ∈ [(25770, true), (155, false)])))
    exact False.elim (arith_521 x (h.bound 2) g0 g1)

private theorem arith_522 (x : Fin 12 → Nat)
    (hb : x 2 ≤ 4) (g0 : (((x 2 * x 2 : Nat) : Int)) ≠ (16 : Int)) (g1 : ((x 2 : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 2) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_522 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25775, true), (157, false)] := by
  refine if hc : Holds (assignment x) [(25775, true), (157, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25775, true) ∈ [(25775, true), (157, false)])))
    have g1 : ((x 2 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (157, false) ∈ [(25775, true), (157, false)])))
    exact False.elim (arith_522 x (h.bound 2) g0 g1)

private theorem arith_523 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_523 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25776, false), (25777, false)] := by
  refine if hc : Holds (assignment x) [(25776, false), (25777, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25776, false), (25777, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25776, false), (25777, false)])))
    exact False.elim (arith_523 x (h.bound 3) g0 g1)

private theorem arith_524 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_524 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25776, false), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25776, false), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25776, false), (25780, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25776, false), (25780, false)])))
    exact False.elim (arith_524 x (h.bound 3) g0 g1)

private theorem arith_525 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_525 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25776, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25776, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25776, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25776, false), (25785, false)])))
    exact False.elim (arith_525 x (h.bound 3) g0 g1)

private theorem arith_526 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_526 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25777, false), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25777, false), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25777, false), (25780, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25777, false), (25780, false)])))
    exact False.elim (arith_526 x (h.bound 3) g0 g1)

private theorem arith_527 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_527 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25783, false), (25777, false)] := by
  refine if hc : Holds (assignment x) [(25783, false), (25777, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25783, false) ∈ [(25783, false), (25777, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25783, false), (25777, false)])))
    exact False.elim (arith_527 x (h.bound 3) g0 g1)

private theorem arith_528 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_528 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25777, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25777, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25777, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25777, false), (25785, false)])))
    exact False.elim (arith_528 x (h.bound 3) g0 g1)

private theorem arith_529 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_529 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25783, false), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25783, false), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25783, false) ∈ [(25783, false), (25780, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25783, false), (25780, false)])))
    exact False.elim (arith_529 x (h.bound 3) g0 g1)

private theorem arith_530 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_530 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25785, false), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25785, false), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25785, false), (25780, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25785, false), (25780, false)])))
    exact False.elim (arith_530 x (h.bound 3) g0 g1)

private theorem arith_531 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_531 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25783, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25783, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25783, false) ∈ [(25783, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25783, false), (25785, false)])))
    exact False.elim (arith_531 x (h.bound 3) g0 g1)

private theorem arith_532 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (0 : Int)) (g1 : ((x 3 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_532 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25776, true), (195, false)] := by
  refine if hc : Holds (assignment x) [(25776, true), (195, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25776, true) ∈ [(25776, true), (195, false)])))
    have g1 : ((x 3 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (195, false) ∈ [(25776, true), (195, false)])))
    exact False.elim (arith_532 x (h.bound 3) g0 g1)

private theorem arith_533 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (1 : Int)) (g1 : ((x 3 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_533 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25777, true), (196, false)] := by
  refine if hc : Holds (assignment x) [(25777, true), (196, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25777, true) ∈ [(25777, true), (196, false)])))
    have g1 : ((x 3 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (196, false) ∈ [(25777, true), (196, false)])))
    exact False.elim (arith_533 x (h.bound 3) g0 g1)

private theorem arith_534 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (4 : Int)) (g1 : ((x 3 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_534 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25780, true), (197, false)] := by
  refine if hc : Holds (assignment x) [(25780, true), (197, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25780, true) ∈ [(25780, true), (197, false)])))
    have g1 : ((x 3 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (197, false) ∈ [(25780, true), (197, false)])))
    exact False.elim (arith_534 x (h.bound 3) g0 g1)

private theorem arith_535 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (9 : Int)) (g1 : ((x 3 : Int)) = (3 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_535 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25783, true), (198, false)] := by
  refine if hc : Holds (assignment x) [(25783, true), (198, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25783, true) ∈ [(25783, true), (198, false)])))
    have g1 : ((x 3 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (198, false) ∈ [(25783, true), (198, false)])))
    exact False.elim (arith_535 x (h.bound 3) g0 g1)

private theorem arith_536 (x : Fin 12 → Nat)
    (hb : x 3 ≤ 4) (g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (16 : Int)) (g1 : ((x 3 : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 3) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_536 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25785, true), (199, false)] := by
  refine if hc : Holds (assignment x) [(25785, true), (199, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 3 * x 3 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25785, true) ∈ [(25785, true), (199, false)])))
    have g1 : ((x 3 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (199, false) ∈ [(25785, true), (199, false)])))
    exact False.elim (arith_536 x (h.bound 3) g0 g1)

private theorem arith_537 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_537 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25786, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25786, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25786, false) ∈ [(25786, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25786, false), (25795, false)])))
    exact False.elim (arith_537 x (h.bound 4) g0 g1)

private theorem arith_538 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : (((x 4 * x 4 : Nat) : Int)) = (1 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_538 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25787, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25787, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 4 * x 4 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25787, false) ∈ [(25787, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25787, false), (25795, false)])))
    exact False.elim (arith_538 x (h.bound 4) g0 g1)

private theorem arith_539 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : (((x 4 * x 4 : Nat) : Int)) = (4 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_539 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25790, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25790, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 4 * x 4 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25790, false) ∈ [(25790, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25790, false), (25795, false)])))
    exact False.elim (arith_539 x (h.bound 4) g0 g1)

private theorem arith_540 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : (((x 4 * x 4 : Nat) : Int)) = (9 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_540 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25793, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25793, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 4 * x 4 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25793, false) ∈ [(25793, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25793, false), (25795, false)])))
    exact False.elim (arith_540 x (h.bound 4) g0 g1)

private theorem arith_541 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : (((x 4 * x 4 : Nat) : Int)) ≠ (0 : Int)) (g1 : ((x 4 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_541 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25786, true), (232, false)] := by
  refine if hc : Holds (assignment x) [(25786, true), (232, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 4 * x 4 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25786, true) ∈ [(25786, true), (232, false)])))
    have g1 : ((x 4 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (232, false) ∈ [(25786, true), (232, false)])))
    exact False.elim (arith_541 x (h.bound 4) g0 g1)

private theorem arith_542 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : (((x 4 * x 4 : Nat) : Int)) ≠ (1 : Int)) (g1 : ((x 4 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_542 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25787, true), (233, false)] := by
  refine if hc : Holds (assignment x) [(25787, true), (233, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 4 * x 4 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25787, true) ∈ [(25787, true), (233, false)])))
    have g1 : ((x 4 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (233, false) ∈ [(25787, true), (233, false)])))
    exact False.elim (arith_542 x (h.bound 4) g0 g1)

private theorem arith_543 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : (((x 4 * x 4 : Nat) : Int)) ≠ (4 : Int)) (g1 : ((x 4 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_543 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25790, true), (234, false)] := by
  refine if hc : Holds (assignment x) [(25790, true), (234, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 4 * x 4 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25790, true) ∈ [(25790, true), (234, false)])))
    have g1 : ((x 4 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (234, false) ∈ [(25790, true), (234, false)])))
    exact False.elim (arith_543 x (h.bound 4) g0 g1)

private theorem arith_544 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : (((x 4 * x 4 : Nat) : Int)) ≠ (9 : Int)) (g1 : ((x 4 : Int)) = (3 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_544 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25793, true), (235, false)] := by
  refine if hc : Holds (assignment x) [(25793, true), (235, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 4 * x 4 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25793, true) ∈ [(25793, true), (235, false)])))
    have g1 : ((x 4 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (235, false) ∈ [(25793, true), (235, false)])))
    exact False.elim (arith_544 x (h.bound 4) g0 g1)

private theorem arith_545 (x : Fin 12 → Nat)
    (hb : x 4 ≤ 4) (g0 : ((x 4 : Int)) = (4 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) ≠ (16 : Int)) : False := by
  rcases fiveCases (x 4) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_545 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(236, false), (25795, true)] := by
  refine if hc : Holds (assignment x) [(236, false), (25795, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 4 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (236, false) ∈ [(236, false), (25795, true)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25795, true) ∈ [(236, false), (25795, true)])))
    exact False.elim (arith_545 x (h.bound 4) g0 g1)

private theorem arith_546 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) = (0 : Int)) (g1 : (((x 5 * x 5 : Nat) : Int)) ≠ (0 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_546 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(264, false), (25796, true)] := by
  refine if hc : Holds (assignment x) [(264, false), (25796, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (264, false) ∈ [(264, false), (25796, true)])))
    have g1 : (((x 5 * x 5 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25796, true) ∈ [(264, false), (25796, true)])))
    exact False.elim (arith_546 x (h.bound 5) g0 g1)

private theorem arith_547 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) = (1 : Int)) (g1 : (((x 5 * x 5 : Nat) : Int)) ≠ (1 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_547 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(265, false), (25797, true)] := by
  refine if hc : Holds (assignment x) [(265, false), (25797, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (265, false) ∈ [(265, false), (25797, true)])))
    have g1 : (((x 5 * x 5 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25797, true) ∈ [(265, false), (25797, true)])))
    exact False.elim (arith_547 x (h.bound 5) g0 g1)

private theorem arith_548 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) = (2 : Int)) (g1 : (((x 5 * x 5 : Nat) : Int)) ≠ (4 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_548 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(266, false), (25800, true)] := by
  refine if hc : Holds (assignment x) [(266, false), (25800, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (266, false) ∈ [(266, false), (25800, true)])))
    have g1 : (((x 5 * x 5 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25800, true) ∈ [(266, false), (25800, true)])))
    exact False.elim (arith_548 x (h.bound 5) g0 g1)

private theorem arith_549 (x : Fin 12 → Nat)
    (hb : x 5 ≤ 4) (g0 : ((x 5 : Int)) = (3 : Int)) (g1 : (((x 5 * x 5 : Nat) : Int)) ≠ (9 : Int)) : False := by
  rcases fiveCases (x 5) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_549 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(267, false), (25803, true)] := by
  refine if hc : Holds (assignment x) [(267, false), (25803, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 5 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (267, false) ∈ [(267, false), (25803, true)])))
    have g1 : (((x 5 * x 5 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25803, true) ∈ [(267, false), (25803, true)])))
    exact False.elim (arith_549 x (h.bound 5) g0 g1)

private theorem arith_550 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : ((x 6 : Int)) = (0 : Int)) (g1 : (((x 6 * x 6 : Nat) : Int)) ≠ (0 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_550 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(291, false), (25806, true)] := by
  refine if hc : Holds (assignment x) [(291, false), (25806, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 6 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (291, false) ∈ [(291, false), (25806, true)])))
    have g1 : (((x 6 * x 6 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25806, true) ∈ [(291, false), (25806, true)])))
    exact False.elim (arith_550 x (h.bound 6) g0 g1)

private theorem arith_551 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : ((x 6 : Int)) = (2 : Int)) (g1 : (((x 6 * x 6 : Nat) : Int)) ≠ (4 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_551 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(293, false), (25810, true)] := by
  refine if hc : Holds (assignment x) [(293, false), (25810, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 6 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (293, false) ∈ [(293, false), (25810, true)])))
    have g1 : (((x 6 * x 6 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25810, true) ∈ [(293, false), (25810, true)])))
    exact False.elim (arith_551 x (h.bound 6) g0 g1)

private theorem arith_552 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : ((x 6 : Int)) = (3 : Int)) (g1 : (((x 6 * x 6 : Nat) : Int)) ≠ (9 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_552 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(294, false), (25813, true)] := by
  refine if hc : Holds (assignment x) [(294, false), (25813, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 6 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (294, false) ∈ [(294, false), (25813, true)])))
    have g1 : (((x 6 * x 6 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25813, true) ∈ [(294, false), (25813, true)])))
    exact False.elim (arith_552 x (h.bound 6) g0 g1)

private theorem arith_553 (x : Fin 12 → Nat)
    (hb : x 6 ≤ 4) (g0 : (((x 6 * x 6 : Nat) : Int)) ≠ (16 : Int)) (g1 : ((x 6 : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 6) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_553 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25815, true), (295, false)] := by
  refine if hc : Holds (assignment x) [(25815, true), (295, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 6 * x 6 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25815, true) ∈ [(25815, true), (295, false)])))
    have g1 : ((x 6 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (295, false) ∈ [(25815, true), (295, false)])))
    exact False.elim (arith_553 x (h.bound 6) g0 g1)

private theorem arith_554 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (0 : Int)) (g1 : ((x 7 : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_554 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25816, true), (313, false)] := by
  refine if hc : Holds (assignment x) [(25816, true), (313, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25816, true) ∈ [(25816, true), (313, false)])))
    have g1 : ((x 7 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (313, false) ∈ [(25816, true), (313, false)])))
    exact False.elim (arith_554 x (h.bound 7) g0 g1)

private theorem arith_555 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (1 : Int)) (g1 : ((x 7 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_555 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25817, true), (314, false)] := by
  refine if hc : Holds (assignment x) [(25817, true), (314, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25817, true) ∈ [(25817, true), (314, false)])))
    have g1 : ((x 7 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (314, false) ∈ [(25817, true), (314, false)])))
    exact False.elim (arith_555 x (h.bound 7) g0 g1)

private theorem arith_556 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (4 : Int)) (g1 : ((x 7 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_556 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25820, true), (315, false)] := by
  refine if hc : Holds (assignment x) [(25820, true), (315, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25820, true) ∈ [(25820, true), (315, false)])))
    have g1 : ((x 7 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (315, false) ∈ [(25820, true), (315, false)])))
    exact False.elim (arith_556 x (h.bound 7) g0 g1)

private theorem arith_557 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (9 : Int)) (g1 : ((x 7 : Int)) = (3 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_557 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25823, true), (316, false)] := by
  refine if hc : Holds (assignment x) [(25823, true), (316, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25823, true) ∈ [(25823, true), (316, false)])))
    have g1 : ((x 7 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (316, false) ∈ [(25823, true), (316, false)])))
    exact False.elim (arith_557 x (h.bound 7) g0 g1)

private theorem arith_558 (x : Fin 12 → Nat)
    (hb : x 7 ≤ 4) (g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (16 : Int)) (g1 : ((x 7 : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 7) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_558 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25825, true), (317, false)] := by
  refine if hc : Holds (assignment x) [(25825, true), (317, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25825, true) ∈ [(25825, true), (317, false)])))
    have g1 : ((x 7 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (317, false) ∈ [(25825, true), (317, false)])))
    exact False.elim (arith_558 x (h.bound 7) g0 g1)

private theorem arith_559 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : (((x 8 * x 8 : Nat) : Int)) = (1 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_559 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25827, false), (25826, false)] := by
  refine if hc : Holds (assignment x) [(25827, false), (25826, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 8 * x 8 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25827, false) ∈ [(25827, false), (25826, false)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(25827, false), (25826, false)])))
    exact False.elim (arith_559 x (h.bound 8) g0 g1)

private theorem arith_560 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : (((x 8 * x 8 : Nat) : Int)) = (4 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_560 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25830, false), (25826, false)] := by
  refine if hc : Holds (assignment x) [(25830, false), (25826, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 8 * x 8 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25830, false) ∈ [(25830, false), (25826, false)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(25830, false), (25826, false)])))
    exact False.elim (arith_560 x (h.bound 8) g0 g1)

private theorem arith_561 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : (((x 8 * x 8 : Nat) : Int)) = (9 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_561 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25833, false), (25826, false)] := by
  refine if hc : Holds (assignment x) [(25833, false), (25826, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 8 * x 8 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25833, false) ∈ [(25833, false), (25826, false)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(25833, false), (25826, false)])))
    exact False.elim (arith_561 x (h.bound 8) g0 g1)

private theorem arith_562 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (16 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_562 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25826, false), (25835, false)] := by
  refine if hc : Holds (assignment x) [(25826, false), (25835, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(25826, false), (25835, false)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25835, false) ∈ [(25826, false), (25835, false)])))
    exact False.elim (arith_562 x (h.bound 8) g0 g1)

private theorem arith_563 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) = (0 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) ≠ (0 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_563 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(330, false), (25826, true)] := by
  refine if hc : Holds (assignment x) [(330, false), (25826, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (330, false) ∈ [(330, false), (25826, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25826, true) ∈ [(330, false), (25826, true)])))
    exact False.elim (arith_563 x (h.bound 8) g0 g1)

private theorem arith_564 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : (((x 8 * x 8 : Nat) : Int)) ≠ (1 : Int)) (g1 : ((x 8 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_564 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25827, true), (331, false)] := by
  refine if hc : Holds (assignment x) [(25827, true), (331, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 8 * x 8 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25827, true) ∈ [(25827, true), (331, false)])))
    have g1 : ((x 8 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (331, false) ∈ [(25827, true), (331, false)])))
    exact False.elim (arith_564 x (h.bound 8) g0 g1)

private theorem arith_565 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : (((x 8 * x 8 : Nat) : Int)) ≠ (4 : Int)) (g1 : ((x 8 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_565 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25830, true), (332, false)] := by
  refine if hc : Holds (assignment x) [(25830, true), (332, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 8 * x 8 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25830, true) ∈ [(25830, true), (332, false)])))
    have g1 : ((x 8 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (332, false) ∈ [(25830, true), (332, false)])))
    exact False.elim (arith_565 x (h.bound 8) g0 g1)

private theorem arith_566 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : (((x 8 * x 8 : Nat) : Int)) ≠ (9 : Int)) (g1 : ((x 8 : Int)) = (3 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_566 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25833, true), (333, false)] := by
  refine if hc : Holds (assignment x) [(25833, true), (333, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 8 * x 8 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25833, true) ∈ [(25833, true), (333, false)])))
    have g1 : ((x 8 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (333, false) ∈ [(25833, true), (333, false)])))
    exact False.elim (arith_566 x (h.bound 8) g0 g1)

private theorem arith_567 (x : Fin 12 → Nat)
    (hb : x 8 ≤ 4) (g0 : ((x 8 : Int)) = (4 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) ≠ (16 : Int)) : False := by
  rcases fiveCases (x 8) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_567 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(334, false), (25835, true)] := by
  refine if hc : Holds (assignment x) [(334, false), (25835, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 8 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (334, false) ∈ [(334, false), (25835, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25835, true) ∈ [(334, false), (25835, true)])))
    exact False.elim (arith_567 x (h.bound 8) g0 g1)

private theorem arith_568 (x : Fin 12 → Nat)
    (hb : x 9 ≤ 4) (g0 : ((x 9 : Int)) = (0 : Int)) (g1 : (((x 9 * x 9 : Nat) : Int)) ≠ (0 : Int)) : False := by
  rcases fiveCases (x 9) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_568 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(342, false), (25836, true)] := by
  refine if hc : Holds (assignment x) [(342, false), (25836, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 9 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (342, false) ∈ [(342, false), (25836, true)])))
    have g1 : (((x 9 * x 9 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25836, true) ∈ [(342, false), (25836, true)])))
    exact False.elim (arith_568 x (h.bound 9) g0 g1)

private theorem arith_569 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : ((x 10 : Int)) = (0 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) ≠ (0 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_569 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(349, false), (25846, true)] := by
  refine if hc : Holds (assignment x) [(349, false), (25846, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (349, false) ∈ [(349, false), (25846, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25846, true) ∈ [(349, false), (25846, true)])))
    exact False.elim (arith_569 x (h.bound 10) g0 g1)

private theorem arith_570 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : (((x 10 * x 10 : Nat) : Int)) ≠ (1 : Int)) (g1 : ((x 10 : Int)) = (1 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_570 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25847, true), (350, false)] := by
  refine if hc : Holds (assignment x) [(25847, true), (350, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 10 * x 10 : Nat) : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25847, true) ∈ [(25847, true), (350, false)])))
    have g1 : ((x 10 : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (350, false) ∈ [(25847, true), (350, false)])))
    exact False.elim (arith_570 x (h.bound 10) g0 g1)

private theorem arith_571 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : (((x 10 * x 10 : Nat) : Int)) ≠ (4 : Int)) (g1 : ((x 10 : Int)) = (2 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_571 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25850, true), (351, false)] := by
  refine if hc : Holds (assignment x) [(25850, true), (351, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 10 * x 10 : Nat) : Int)) ≠ (4 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25850, true) ∈ [(25850, true), (351, false)])))
    have g1 : ((x 10 : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (351, false) ∈ [(25850, true), (351, false)])))
    exact False.elim (arith_571 x (h.bound 10) g0 g1)

private theorem arith_572 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : ((x 10 : Int)) = (3 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) ≠ (9 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_572 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(352, false), (25853, true)] := by
  refine if hc : Holds (assignment x) [(352, false), (25853, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 10 : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (352, false) ∈ [(352, false), (25853, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25853, true) ∈ [(352, false), (25853, true)])))
    exact False.elim (arith_572 x (h.bound 10) g0 g1)

private theorem arith_573 (x : Fin 12 → Nat)
    (hb : x 10 ≤ 4) (g0 : (((x 10 * x 10 : Nat) : Int)) ≠ (16 : Int)) (g1 : ((x 10 : Int)) = (4 : Int)) : False := by
  rcases fiveCases (x 10) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_573 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25855, true), (353, false)] := by
  refine if hc : Holds (assignment x) [(25855, true), (353, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 10 * x 10 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25855, true) ∈ [(25855, true), (353, false)])))
    have g1 : ((x 10 : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (353, false) ∈ [(25855, true), (353, false)])))
    exact False.elim (arith_573 x (h.bound 10) g0 g1)

private theorem arith_574 (x : Fin 12 → Nat)
    (hb : x 11 ≤ 4) (hd : x 11 = 0 ∨ x 11 = 2) (g0 : ((x 11 : Int)) = (0 : Int)) (g1 : (((x 11 * x 11 : Nat) : Int)) ≠ (0 : Int)) : False := by
  rcases fiveCases (x 11) hb with hx | hx | hx | hx | hx
  all_goals simp only [hx] at * <;> omega

theorem clause_574 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(354, false), (25856, true)] := by
  refine if hc : Holds (assignment x) [(354, false), (25856, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(354, false), (25856, true)])))
    have g1 : (((x 11 * x 11 : Nat) : Int)) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25856, true) ∈ [(354, false), (25856, true)])))
    exact False.elim (arith_574 x (h.bound 11) h.diagonal g0 g1)

private theorem arith_575 (x : Fin 12 → Nat)
    (g0 : ((9 : Int)) ≠ (9 : Int)) (g1 : ((9 : Int)) = (9 : Int)) (g2 : (0 : Int) = (0 : Int)) : False := by
  omega

theorem clause_575 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25865, true), (25753, false), (1, false)] := by
  refine if hc : Holds (assignment x) [(25865, true), (25753, false), (1, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25865, true) ∈ [(25865, true), (25753, false), (1, false)])))
    have g1 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25753, false) ∈ [(25865, true), (25753, false), (1, false)])))
    have g2 : (0 : Int) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (1, false) ∈ [(25865, true), (25753, false), (1, false)])))
    exact False.elim (arith_575 x g0 g1 g2)

private theorem arith_576 (x : Fin 12 → Nat)
    (g0 : (((x 1 * x 1 : Nat) : Int)) = (0 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (9 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_576 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25756, false), (25875, true), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25756, false), (25875, true), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25756, false) ∈ [(25756, false), (25875, true), (25865, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25875, true) ∈ [(25756, false), (25875, true), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25756, false), (25875, true), (25865, false)])))
    exact False.elim (arith_576 x g0 g1 g2)

private theorem arith_577 (x : Fin 12 → Nat)
    (g0 : (((x 1 * x 1 : Nat) : Int)) = (1 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (10 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_577 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25757, false), (25880, true), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25757, false), (25880, true), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25757, false) ∈ [(25757, false), (25880, true), (25865, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25880, true) ∈ [(25757, false), (25880, true), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25757, false), (25880, true), (25865, false)])))
    exact False.elim (arith_577 x g0 g1 g2)

private theorem arith_578 (x : Fin 12 → Nat)
    (g0 : (((x 1 * x 1 : Nat) : Int)) = (2 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (11 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_578 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25758, false), (25883, true), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25758, false), (25883, true), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (2 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25758, false) ∈ [(25758, false), (25883, true), (25865, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25883, true) ∈ [(25758, false), (25883, true), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25758, false), (25883, true), (25865, false)])))
    exact False.elim (arith_578 x g0 g1 g2)

private theorem arith_579 (x : Fin 12 → Nat)
    (g0 : (((x 1 * x 1 : Nat) : Int)) = (3 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (12 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_579 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25759, false), (25876, true), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25759, false), (25876, true), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (3 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25759, false) ∈ [(25759, false), (25876, true), (25865, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25876, true) ∈ [(25759, false), (25876, true), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25759, false), (25876, true), (25865, false)])))
    exact False.elim (arith_579 x g0 g1 g2)

private theorem arith_580 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (13 : Int)) (g1 : (((x 1 * x 1 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_580 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25881, true), (25760, false), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25881, true), (25760, false), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25881, true) ∈ [(25881, true), (25760, false), (25865, false)])))
    have g1 : (((x 1 * x 1 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25760, false) ∈ [(25881, true), (25760, false), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25881, true), (25760, false), (25865, false)])))
    exact False.elim (arith_580 x g0 g1 g2)

private theorem arith_581 (x : Fin 12 → Nat)
    (g0 : (((x 1 * x 1 : Nat) : Int)) = (6 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (15 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_581 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25761, false), (25886, true), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25761, false), (25886, true), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (6 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25761, false) ∈ [(25761, false), (25886, true), (25865, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25886, true) ∈ [(25761, false), (25886, true), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25761, false), (25886, true), (25865, false)])))
    exact False.elim (arith_581 x g0 g1 g2)

private theorem arith_582 (x : Fin 12 → Nat)
    (g0 : (((x 1 * x 1 : Nat) : Int)) = (8 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (17 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_582 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25762, false), (25882, true), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25762, false), (25882, true), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (8 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25762, false) ∈ [(25762, false), (25882, true), (25865, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25882, true) ∈ [(25762, false), (25882, true), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25762, false), (25882, true), (25865, false)])))
    exact False.elim (arith_582 x g0 g1 g2)

private theorem arith_583 (x : Fin 12 → Nat)
    (g0 : (((x 1 * x 1 : Nat) : Int)) = (9 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (18 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_583 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25763, false), (25885, true), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25763, false), (25885, true), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25763, false) ∈ [(25763, false), (25885, true), (25865, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25885, true) ∈ [(25763, false), (25885, true), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25763, false), (25885, true), (25865, false)])))
    exact False.elim (arith_583 x g0 g1 g2)

private theorem arith_584 (x : Fin 12 → Nat)
    (g0 : (((x 1 * x 1 : Nat) : Int)) = (12 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (21 : Int)) (g2 : ((9 : Int)) = (9 : Int)) : False := by
  omega

theorem clause_584 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25764, false), (25891, true), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25764, false), (25891, true), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25764, false) ∈ [(25764, false), (25891, true), (25865, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) ≠ (21 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25891, true) ∈ [(25764, false), (25891, true), (25865, false)])))
    have g2 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25764, false), (25891, true), (25865, false)])))
    exact False.elim (arith_584 x g0 g1 g2)

private theorem arith_585 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : (((x 1 * x 1 : Nat) : Int)) = (16 : Int)) (g1 : ((9 : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_585 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25765, false), (25865, false)] := by
  refine if hc : Holds (assignment x) [(25765, false), (25865, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 1 * x 1 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25765, false) ∈ [(25765, false), (25865, false)])))
    have g1 : ((9 : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25865, false) ∈ [(25765, false), (25865, false)])))
    exact False.elim (arith_585 x h.zero h.square g0 g1)

private theorem arith_586 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int)) : False := by
  omega

theorem clause_586 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25875, false), (25881, false)] := by
  refine if hc : Holds (assignment x) [(25875, false), (25881, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25875, false) ∈ [(25875, false), (25881, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25881, false) ∈ [(25875, false), (25881, false)])))
    exact False.elim (arith_586 x g0 g1)

private theorem arith_587 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int)) : False := by
  omega

theorem clause_587 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25885, false), (25881, false)] := by
  refine if hc : Holds (assignment x) [(25885, false), (25881, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25885, false) ∈ [(25885, false), (25881, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25881, false) ∈ [(25885, false), (25881, false)])))
    exact False.elim (arith_587 x g0 g1)

private theorem arith_588 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_588 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25875, false), (25766, false), (25899, true)] := by
  refine if hc : Holds (assignment x) [(25875, false), (25766, false), (25899, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25875, false) ∈ [(25875, false), (25766, false), (25899, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25875, false), (25766, false), (25899, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25899, true) ∈ [(25875, false), (25766, false), (25899, true)])))
    exact False.elim (arith_588 x g0 g1 g2)

private theorem arith_589 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_589 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25875, false), (25767, false), (25904, true)] := by
  refine if hc : Holds (assignment x) [(25875, false), (25767, false), (25904, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25875, false) ∈ [(25875, false), (25767, false), (25904, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25875, false), (25767, false), (25904, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25904, true) ∈ [(25875, false), (25767, false), (25904, true)])))
    exact False.elim (arith_589 x g0 g1 g2)

private theorem arith_590 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (13 : Int)) : False := by
  omega

theorem clause_590 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25875, false), (25770, false), (25905, true)] := by
  refine if hc : Holds (assignment x) [(25875, false), (25770, false), (25905, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25875, false) ∈ [(25875, false), (25770, false), (25905, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25875, false), (25770, false), (25905, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25905, true) ∈ [(25875, false), (25770, false), (25905, true)])))
    exact False.elim (arith_590 x g0 g1 g2)

private theorem arith_591 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_591 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25875, false), (25775, false)] := by
  refine if hc : Holds (assignment x) [(25875, false), (25775, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25875, false) ∈ [(25875, false), (25775, false)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25775, false) ∈ [(25875, false), (25775, false)])))
    exact False.elim (arith_591 x h.zero h.square g0 g1)

private theorem arith_592 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (12 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_592 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25876, false), (25766, false), (25900, true)] := by
  refine if hc : Holds (assignment x) [(25876, false), (25766, false), (25900, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25876, false) ∈ [(25876, false), (25766, false), (25900, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25876, false), (25766, false), (25900, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25900, true) ∈ [(25876, false), (25766, false), (25900, true)])))
    exact False.elim (arith_592 x g0 g1 g2)

private theorem arith_593 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (12 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (13 : Int)) : False := by
  omega

theorem clause_593 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25876, false), (25767, false), (25905, true)] := by
  refine if hc : Holds (assignment x) [(25876, false), (25767, false), (25905, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25876, false) ∈ [(25876, false), (25767, false), (25905, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25876, false), (25767, false), (25905, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25905, true) ∈ [(25876, false), (25767, false), (25905, true)])))
    exact False.elim (arith_593 x g0 g1 g2)

private theorem arith_594 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (12 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (16 : Int)) : False := by
  omega

theorem clause_594 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25876, false), (25770, false), (25901, true)] := by
  refine if hc : Holds (assignment x) [(25876, false), (25770, false), (25901, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25876, false) ∈ [(25876, false), (25770, false), (25901, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25876, false), (25770, false), (25901, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25901, true) ∈ [(25876, false), (25770, false), (25901, true)])))
    exact False.elim (arith_594 x g0 g1 g2)

private theorem arith_595 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (10 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int)) : False := by
  omega

theorem clause_595 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25766, false), (25904, true), (25880, false)] := by
  refine if hc : Holds (assignment x) [(25766, false), (25904, true), (25880, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25766, false), (25904, true), (25880, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25904, true) ∈ [(25766, false), (25904, true), (25880, false)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25880, false) ∈ [(25766, false), (25904, true), (25880, false)])))
    exact False.elim (arith_595 x g0 g1 g2)

private theorem arith_596 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (11 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int)) : False := by
  omega

theorem clause_596 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25767, false), (25907, true), (25880, false)] := by
  refine if hc : Holds (assignment x) [(25767, false), (25907, true), (25880, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25767, false), (25907, true), (25880, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25907, true) ∈ [(25767, false), (25907, true), (25880, false)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25880, false) ∈ [(25767, false), (25907, true), (25880, false)])))
    exact False.elim (arith_596 x g0 g1 g2)

private theorem arith_597 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (14 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int)) : False := by
  omega

theorem clause_597 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25770, false), (25908, true), (25880, false)] := by
  refine if hc : Holds (assignment x) [(25770, false), (25908, true), (25880, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25770, false), (25908, true), (25880, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25908, true) ∈ [(25770, false), (25908, true), (25880, false)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25880, false) ∈ [(25770, false), (25908, true), (25880, false)])))
    exact False.elim (arith_597 x g0 g1 g2)

private theorem arith_598 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_598 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25880, false), (25775, false)] := by
  refine if hc : Holds (assignment x) [(25880, false), (25775, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25880, false) ∈ [(25880, false), (25775, false)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25775, false) ∈ [(25880, false), (25775, false)])))
    exact False.elim (arith_598 x h.zero h.square g0 g1)

private theorem arith_599 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (13 : Int)) : False := by
  omega

theorem clause_599 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25766, false), (25881, false), (25905, true)] := by
  refine if hc : Holds (assignment x) [(25766, false), (25881, false), (25905, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25766, false), (25881, false), (25905, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25881, false) ∈ [(25766, false), (25881, false), (25905, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25905, true) ∈ [(25766, false), (25881, false), (25905, true)])))
    exact False.elim (arith_599 x g0 g1 g2)

private theorem arith_600 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_600 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25767, false), (25881, false), (25908, true)] := by
  refine if hc : Holds (assignment x) [(25767, false), (25881, false), (25908, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25767, false), (25881, false), (25908, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25881, false) ∈ [(25767, false), (25881, false), (25908, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25908, true) ∈ [(25767, false), (25881, false), (25908, true)])))
    exact False.elim (arith_600 x g0 g1 g2)

private theorem arith_601 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_601 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25770, false), (25881, false), (25906, true)] := by
  refine if hc : Holds (assignment x) [(25770, false), (25881, false), (25906, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25770, false), (25881, false), (25906, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25881, false) ∈ [(25770, false), (25881, false), (25906, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25906, true) ∈ [(25770, false), (25881, false), (25906, true)])))
    exact False.elim (arith_601 x g0 g1 g2)

private theorem arith_602 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_602 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25881, false), (25775, false)] := by
  refine if hc : Holds (assignment x) [(25881, false), (25775, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25881, false) ∈ [(25881, false), (25775, false)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25775, false) ∈ [(25881, false), (25775, false)])))
    exact False.elim (arith_602 x h.zero h.square g0 g1)

private theorem arith_603 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (17 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_603 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25882, false), (25766, false), (25906, true)] := by
  refine if hc : Holds (assignment x) [(25882, false), (25766, false), (25906, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25882, false) ∈ [(25882, false), (25766, false), (25906, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25882, false), (25766, false), (25906, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25906, true) ∈ [(25882, false), (25766, false), (25906, true)])))
    exact False.elim (arith_603 x g0 g1 g2)

private theorem arith_604 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (17 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_604 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25882, false), (25767, false), (25909, true)] := by
  refine if hc : Holds (assignment x) [(25882, false), (25767, false), (25909, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25882, false) ∈ [(25882, false), (25767, false), (25909, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25882, false), (25767, false), (25909, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25909, true) ∈ [(25882, false), (25767, false), (25909, true)])))
    exact False.elim (arith_604 x g0 g1 g2)

private theorem arith_605 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (17 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (21 : Int)) : False := by
  omega

theorem clause_605 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25882, false), (25770, false), (25915, true)] := by
  refine if hc : Holds (assignment x) [(25882, false), (25770, false), (25915, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25882, false) ∈ [(25882, false), (25770, false), (25915, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25882, false), (25770, false), (25915, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (21 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25915, true) ∈ [(25882, false), (25770, false), (25915, true)])))
    exact False.elim (arith_605 x g0 g1 g2)

private theorem arith_606 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (11 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_606 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25883, false), (25766, false), (25907, true)] := by
  refine if hc : Holds (assignment x) [(25883, false), (25766, false), (25907, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25883, false) ∈ [(25883, false), (25766, false), (25907, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25883, false), (25766, false), (25907, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25907, true) ∈ [(25883, false), (25766, false), (25907, true)])))
    exact False.elim (arith_606 x g0 g1 g2)

private theorem arith_607 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (11 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_607 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25883, false), (25767, false), (25900, true)] := by
  refine if hc : Holds (assignment x) [(25883, false), (25767, false), (25900, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25883, false) ∈ [(25883, false), (25767, false), (25900, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25883, false), (25767, false), (25900, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25900, true) ∈ [(25883, false), (25767, false), (25900, true)])))
    exact False.elim (arith_607 x g0 g1 g2)

private theorem arith_608 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (11 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_608 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25883, false), (25770, false), (25910, true)] := by
  refine if hc : Holds (assignment x) [(25883, false), (25770, false), (25910, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25883, false) ∈ [(25883, false), (25770, false), (25910, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25883, false), (25770, false), (25910, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25910, true) ∈ [(25883, false), (25770, false), (25910, true)])))
    exact False.elim (arith_608 x g0 g1 g2)

private theorem arith_609 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_609 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25766, false), (25885, false), (25909, true)] := by
  refine if hc : Holds (assignment x) [(25766, false), (25885, false), (25909, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25766, false), (25885, false), (25909, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25885, false) ∈ [(25766, false), (25885, false), (25909, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25909, true) ∈ [(25766, false), (25885, false), (25909, true)])))
    exact False.elim (arith_609 x g0 g1 g2)

private theorem arith_610 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (19 : Int)) : False := by
  omega

theorem clause_610 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25767, false), (25885, false), (25911, true)] := by
  refine if hc : Holds (assignment x) [(25767, false), (25885, false), (25911, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25767, false), (25885, false), (25911, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25885, false) ∈ [(25767, false), (25885, false), (25911, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (19 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25911, true) ∈ [(25767, false), (25885, false), (25911, true)])))
    exact False.elim (arith_610 x g0 g1 g2)

private theorem arith_611 (x : Fin 12 → Nat)
    (g0 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_611 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25770, false), (25885, false), (25913, true)] := by
  refine if hc : Holds (assignment x) [(25770, false), (25885, false), (25913, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25770, false), (25885, false), (25913, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25885, false) ∈ [(25770, false), (25885, false), (25913, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25913, true) ∈ [(25770, false), (25885, false), (25913, true)])))
    exact False.elim (arith_611 x g0 g1 g2)

private theorem arith_612 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_612 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25885, false), (25775, false)] := by
  refine if hc : Holds (assignment x) [(25885, false), (25775, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25885, false) ∈ [(25885, false), (25775, false)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25775, false) ∈ [(25885, false), (25775, false)])))
    exact False.elim (arith_612 x h.zero h.square g0 g1)

private theorem arith_613 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (15 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_613 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25886, false), (25766, false), (25910, true)] := by
  refine if hc : Holds (assignment x) [(25886, false), (25766, false), (25910, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25886, false) ∈ [(25886, false), (25766, false), (25910, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25886, false), (25766, false), (25910, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25910, true) ∈ [(25886, false), (25766, false), (25910, true)])))
    exact False.elim (arith_613 x g0 g1 g2)

private theorem arith_614 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (15 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (16 : Int)) : False := by
  omega

theorem clause_614 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25886, false), (25767, false), (25901, true)] := by
  refine if hc : Holds (assignment x) [(25886, false), (25767, false), (25901, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25886, false) ∈ [(25886, false), (25767, false), (25901, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25886, false), (25767, false), (25901, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25901, true) ∈ [(25886, false), (25767, false), (25901, true)])))
    exact False.elim (arith_614 x g0 g1 g2)

private theorem arith_615 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (15 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (19 : Int)) : False := by
  omega

theorem clause_615 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25886, false), (25770, false), (25911, true)] := by
  refine if hc : Holds (assignment x) [(25886, false), (25770, false), (25911, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25886, false) ∈ [(25886, false), (25770, false), (25911, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25886, false), (25770, false), (25911, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (19 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25911, true) ∈ [(25886, false), (25770, false), (25911, true)])))
    exact False.elim (arith_615 x g0 g1 g2)

private theorem arith_616 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (21 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (21 : Int)) : False := by
  omega

theorem clause_616 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25891, false), (25766, false), (25915, true)] := by
  refine if hc : Holds (assignment x) [(25891, false), (25766, false), (25915, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (21 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25891, false) ∈ [(25891, false), (25766, false), (25915, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25766, false) ∈ [(25891, false), (25766, false), (25915, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (21 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25915, true) ∈ [(25891, false), (25766, false), (25915, true)])))
    exact False.elim (arith_616 x g0 g1 g2)

private theorem arith_617 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (21 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_617 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25891, false), (25767, false), (25913, true)] := by
  refine if hc : Holds (assignment x) [(25891, false), (25767, false), (25913, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (21 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25891, false) ∈ [(25891, false), (25767, false), (25913, true)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25767, false) ∈ [(25891, false), (25767, false), (25913, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25913, true) ∈ [(25891, false), (25767, false), (25913, true)])))
    exact False.elim (arith_617 x g0 g1 g2)

private theorem arith_618 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (21 : Int)) (g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_618 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25891, false), (25770, false)] := by
  refine if hc : Holds (assignment x) [(25891, false), (25770, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int)) = (21 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25891, false) ∈ [(25891, false), (25770, false)])))
    have g1 : (((x 2 * x 2 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25770, false) ∈ [(25891, false), (25770, false)])))
    exact False.elim (arith_618 x h.zero h.square g0 g1)

private theorem arith_619 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (9 : Int)) : False := by
  omega

theorem clause_619 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25899, false), (25776, false), (25924, true)] := by
  refine if hc : Holds (assignment x) [(25899, false), (25776, false), (25924, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25899, false) ∈ [(25899, false), (25776, false), (25924, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25899, false), (25776, false), (25924, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25924, true) ∈ [(25899, false), (25776, false), (25924, true)])))
    exact False.elim (arith_619 x g0 g1 g2)

private theorem arith_620 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_620 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25899, false), (25777, false), (25929, true)] := by
  refine if hc : Holds (assignment x) [(25899, false), (25777, false), (25929, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25899, false) ∈ [(25899, false), (25777, false), (25929, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25899, false), (25777, false), (25929, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25929, true) ∈ [(25899, false), (25777, false), (25929, true)])))
    exact False.elim (arith_620 x g0 g1 g2)

private theorem arith_621 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (13 : Int)) (g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_621 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25899, false), (25930, true), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25899, false), (25930, true), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25899, false) ∈ [(25899, false), (25930, true), (25780, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25930, true) ∈ [(25899, false), (25930, true), (25780, false)])))
    have g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25899, false), (25930, true), (25780, false)])))
    exact False.elim (arith_621 x g0 g1 g2)

private theorem arith_622 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_622 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25899, false), (25783, false), (25934, true)] := by
  refine if hc : Holds (assignment x) [(25899, false), (25783, false), (25934, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25899, false) ∈ [(25899, false), (25783, false), (25934, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25783, false) ∈ [(25899, false), (25783, false), (25934, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25934, true) ∈ [(25899, false), (25783, false), (25934, true)])))
    exact False.elim (arith_622 x g0 g1 g2)

private theorem arith_623 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_623 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25899, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25899, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25899, false) ∈ [(25899, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25899, false), (25785, false)])))
    exact False.elim (arith_623 x h.zero h.square g0 g1)

private theorem arith_624 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_624 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25900, false), (25776, false), (25925, true)] := by
  refine if hc : Holds (assignment x) [(25900, false), (25776, false), (25925, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25900, false) ∈ [(25900, false), (25776, false), (25925, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25900, false), (25776, false), (25925, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25925, true) ∈ [(25900, false), (25776, false), (25925, true)])))
    exact False.elim (arith_624 x g0 g1 g2)

private theorem arith_625 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (13 : Int)) : False := by
  omega

theorem clause_625 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25900, false), (25777, false), (25930, true)] := by
  refine if hc : Holds (assignment x) [(25900, false), (25777, false), (25930, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25900, false) ∈ [(25900, false), (25777, false), (25930, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25900, false), (25777, false), (25930, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25930, true) ∈ [(25900, false), (25777, false), (25930, true)])))
    exact False.elim (arith_625 x g0 g1 g2)

private theorem arith_626 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (16 : Int)) (g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_626 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25900, false), (25926, true), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25900, false), (25926, true), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25900, false) ∈ [(25900, false), (25926, true), (25780, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25926, true) ∈ [(25900, false), (25926, true), (25780, false)])))
    have g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25900, false), (25926, true), (25780, false)])))
    exact False.elim (arith_626 x g0 g1 g2)

private theorem arith_627 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_627 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25900, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25900, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25900, false) ∈ [(25900, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25900, false), (25785, false)])))
    exact False.elim (arith_627 x h.zero h.square g0 g1)

private theorem arith_628 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (16 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (16 : Int)) : False := by
  omega

theorem clause_628 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25901, false), (25776, false), (25926, true)] := by
  refine if hc : Holds (assignment x) [(25901, false), (25776, false), (25926, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25901, false) ∈ [(25901, false), (25776, false), (25926, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25901, false), (25776, false), (25926, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25926, true) ∈ [(25901, false), (25776, false), (25926, true)])))
    exact False.elim (arith_628 x g0 g1 g2)

private theorem arith_629 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (16 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_629 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25901, false), (25777, false), (25931, true)] := by
  refine if hc : Holds (assignment x) [(25901, false), (25777, false), (25931, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25901, false) ∈ [(25901, false), (25777, false), (25931, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25901, false), (25777, false), (25931, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25931, true) ∈ [(25901, false), (25777, false), (25931, true)])))
    exact False.elim (arith_629 x g0 g1 g2)

private theorem arith_630 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (16 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_630 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25901, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25901, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25901, false) ∈ [(25901, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25901, false), (25785, false)])))
    exact False.elim (arith_630 x h.zero h.square g0 g1)

private theorem arith_631 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (10 : Int)) : False := by
  omega

theorem clause_631 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25904, false), (25776, false), (25929, true)] := by
  refine if hc : Holds (assignment x) [(25904, false), (25776, false), (25929, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25904, false) ∈ [(25904, false), (25776, false), (25929, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25904, false), (25776, false), (25929, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25929, true) ∈ [(25904, false), (25776, false), (25929, true)])))
    exact False.elim (arith_631 x g0 g1 g2)

private theorem arith_632 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_632 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25904, false), (25777, false), (25932, true)] := by
  refine if hc : Holds (assignment x) [(25904, false), (25777, false), (25932, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25904, false) ∈ [(25904, false), (25777, false), (25932, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25904, false), (25777, false), (25932, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25932, true) ∈ [(25904, false), (25777, false), (25932, true)])))
    exact False.elim (arith_632 x g0 g1 g2)

private theorem arith_633 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (14 : Int)) (g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_633 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25904, false), (25933, true), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25904, false), (25933, true), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25904, false) ∈ [(25904, false), (25933, true), (25780, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25933, true) ∈ [(25904, false), (25933, true), (25780, false)])))
    have g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25904, false), (25933, true), (25780, false)])))
    exact False.elim (arith_633 x g0 g1 g2)

private theorem arith_634 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_634 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25904, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25904, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25904, false) ∈ [(25904, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25904, false), (25785, false)])))
    exact False.elim (arith_634 x h.zero h.square g0 g1)

private theorem arith_635 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (13 : Int)) : False := by
  omega

theorem clause_635 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25905, false), (25776, false), (25930, true)] := by
  refine if hc : Holds (assignment x) [(25905, false), (25776, false), (25930, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25905, false) ∈ [(25905, false), (25776, false), (25930, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25905, false), (25776, false), (25930, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25930, true) ∈ [(25905, false), (25776, false), (25930, true)])))
    exact False.elim (arith_635 x g0 g1 g2)

private theorem arith_636 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_636 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25905, false), (25777, false), (25933, true)] := by
  refine if hc : Holds (assignment x) [(25905, false), (25777, false), (25933, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25905, false) ∈ [(25905, false), (25777, false), (25933, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25905, false), (25777, false), (25933, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25933, true) ∈ [(25905, false), (25777, false), (25933, true)])))
    exact False.elim (arith_636 x g0 g1 g2)

private theorem arith_637 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (17 : Int)) (g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_637 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25905, false), (25931, true), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25905, false), (25931, true), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25905, false) ∈ [(25905, false), (25931, true), (25780, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25931, true) ∈ [(25905, false), (25931, true), (25780, false)])))
    have g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25905, false), (25931, true), (25780, false)])))
    exact False.elim (arith_637 x g0 g1 g2)

private theorem arith_638 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_638 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25905, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25905, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25905, false) ∈ [(25905, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25905, false), (25785, false)])))
    exact False.elim (arith_638 x h.zero h.square g0 g1)

private theorem arith_639 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_639 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25906, false), (25776, false), (25931, true)] := by
  refine if hc : Holds (assignment x) [(25906, false), (25776, false), (25931, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25906, false) ∈ [(25906, false), (25776, false), (25931, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25906, false), (25776, false), (25931, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25931, true) ∈ [(25906, false), (25776, false), (25931, true)])))
    exact False.elim (arith_639 x g0 g1 g2)

private theorem arith_640 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_640 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25906, false), (25777, false), (25934, true)] := by
  refine if hc : Holds (assignment x) [(25906, false), (25777, false), (25934, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25906, false) ∈ [(25906, false), (25777, false), (25934, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25906, false), (25777, false), (25934, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25934, true) ∈ [(25906, false), (25777, false), (25934, true)])))
    exact False.elim (arith_640 x g0 g1 g2)

private theorem arith_641 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (21 : Int)) (g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_641 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25906, false), (25940, true), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25906, false), (25940, true), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25906, false) ∈ [(25906, false), (25940, true), (25780, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (21 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25940, true) ∈ [(25906, false), (25940, true), (25780, false)])))
    have g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25906, false), (25940, true), (25780, false)])))
    exact False.elim (arith_641 x g0 g1 g2)

private theorem arith_642 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_642 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25906, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25906, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25906, false) ∈ [(25906, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25906, false), (25785, false)])))
    exact False.elim (arith_642 x h.zero h.square g0 g1)

private theorem arith_643 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (11 : Int)) : False := by
  omega

theorem clause_643 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25907, false), (25776, false), (25932, true)] := by
  refine if hc : Holds (assignment x) [(25907, false), (25776, false), (25932, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25907, false) ∈ [(25907, false), (25776, false), (25932, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25907, false), (25776, false), (25932, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25932, true) ∈ [(25907, false), (25776, false), (25932, true)])))
    exact False.elim (arith_643 x g0 g1 g2)

private theorem arith_644 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_644 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25907, false), (25777, false), (25925, true)] := by
  refine if hc : Holds (assignment x) [(25907, false), (25777, false), (25925, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25907, false) ∈ [(25907, false), (25777, false), (25925, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25907, false), (25777, false), (25925, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25925, true) ∈ [(25907, false), (25777, false), (25925, true)])))
    exact False.elim (arith_644 x g0 g1 g2)

private theorem arith_645 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (15 : Int)) (g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_645 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25907, false), (25935, true), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25907, false), (25935, true), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25907, false) ∈ [(25907, false), (25935, true), (25780, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25935, true) ∈ [(25907, false), (25935, true), (25780, false)])))
    have g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25907, false), (25935, true), (25780, false)])))
    exact False.elim (arith_645 x g0 g1 g2)

private theorem arith_646 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_646 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25907, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25907, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25907, false) ∈ [(25907, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25907, false), (25785, false)])))
    exact False.elim (arith_646 x h.zero h.square g0 g1)

private theorem arith_647 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_647 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25908, false), (25776, false), (25933, true)] := by
  refine if hc : Holds (assignment x) [(25908, false), (25776, false), (25933, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25908, false) ∈ [(25908, false), (25776, false), (25933, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25908, false), (25776, false), (25933, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25933, true) ∈ [(25908, false), (25776, false), (25933, true)])))
    exact False.elim (arith_647 x g0 g1 g2)

private theorem arith_648 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_648 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25908, false), (25777, false), (25935, true)] := by
  refine if hc : Holds (assignment x) [(25908, false), (25777, false), (25935, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25908, false) ∈ [(25908, false), (25777, false), (25935, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25908, false), (25777, false), (25935, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25935, true) ∈ [(25908, false), (25777, false), (25935, true)])))
    exact False.elim (arith_648 x g0 g1 g2)

private theorem arith_649 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_649 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25908, false), (25780, false), (25934, true)] := by
  refine if hc : Holds (assignment x) [(25908, false), (25780, false), (25934, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25908, false) ∈ [(25908, false), (25780, false), (25934, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25908, false), (25780, false), (25934, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25934, true) ∈ [(25908, false), (25780, false), (25934, true)])))
    exact False.elim (arith_649 x g0 g1 g2)

private theorem arith_650 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_650 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25908, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25908, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25908, false) ∈ [(25908, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25908, false), (25785, false)])))
    exact False.elim (arith_650 x h.zero h.square g0 g1)

private theorem arith_651 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_651 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25909, false), (25776, false), (25934, true)] := by
  refine if hc : Holds (assignment x) [(25909, false), (25776, false), (25934, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25909, false) ∈ [(25909, false), (25776, false), (25934, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25909, false), (25776, false), (25934, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25934, true) ∈ [(25909, false), (25776, false), (25934, true)])))
    exact False.elim (arith_651 x g0 g1 g2)

private theorem arith_652 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (19 : Int)) : False := by
  omega

theorem clause_652 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25909, false), (25777, false), (25936, true)] := by
  refine if hc : Holds (assignment x) [(25909, false), (25777, false), (25936, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25909, false) ∈ [(25909, false), (25777, false), (25936, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25909, false), (25777, false), (25936, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (19 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25936, true) ∈ [(25909, false), (25777, false), (25936, true)])))
    exact False.elim (arith_652 x g0 g1 g2)

private theorem arith_653 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (22 : Int)) (g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_653 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25909, false), (25938, true), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25909, false), (25938, true), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25909, false) ∈ [(25909, false), (25938, true), (25780, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25938, true) ∈ [(25909, false), (25938, true), (25780, false)])))
    have g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25909, false), (25938, true), (25780, false)])))
    exact False.elim (arith_653 x g0 g1 g2)

private theorem arith_654 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_654 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25909, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25909, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25909, false) ∈ [(25909, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25909, false), (25785, false)])))
    exact False.elim (arith_654 x h.zero h.square g0 g1)

private theorem arith_655 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (15 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_655 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25910, false), (25776, false), (25935, true)] := by
  refine if hc : Holds (assignment x) [(25910, false), (25776, false), (25935, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25910, false) ∈ [(25910, false), (25776, false), (25935, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25910, false), (25776, false), (25935, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25935, true) ∈ [(25910, false), (25776, false), (25935, true)])))
    exact False.elim (arith_655 x g0 g1 g2)

private theorem arith_656 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (15 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (19 : Int)) (g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_656 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25910, false), (25936, true), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25910, false), (25936, true), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25910, false) ∈ [(25910, false), (25936, true), (25780, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (19 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25936, true) ∈ [(25910, false), (25936, true), (25780, false)])))
    have g2 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25910, false), (25936, true), (25780, false)])))
    exact False.elim (arith_656 x g0 g1 g2)

private theorem arith_657 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (15 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_657 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25910, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25910, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25910, false) ∈ [(25910, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25910, false), (25785, false)])))
    exact False.elim (arith_657 x h.zero h.square g0 g1)

private theorem arith_658 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (19 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (19 : Int)) : False := by
  omega

theorem clause_658 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25911, false), (25776, false), (25936, true)] := by
  refine if hc : Holds (assignment x) [(25911, false), (25776, false), (25936, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (19 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25911, false) ∈ [(25911, false), (25776, false), (25936, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25911, false), (25776, false), (25936, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (19 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25936, true) ∈ [(25911, false), (25776, false), (25936, true)])))
    exact False.elim (arith_658 x g0 g1 g2)

private theorem arith_659 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (19 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (20 : Int)) : False := by
  omega

theorem clause_659 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25911, false), (25777, false), (25937, true)] := by
  refine if hc : Holds (assignment x) [(25911, false), (25777, false), (25937, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (19 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25911, false) ∈ [(25911, false), (25777, false), (25937, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25911, false), (25777, false), (25937, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (20 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25937, true) ∈ [(25911, false), (25777, false), (25937, true)])))
    exact False.elim (arith_659 x g0 g1 g2)

private theorem arith_660 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (19 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_660 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25911, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25911, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (19 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25911, false) ∈ [(25911, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25911, false), (25785, false)])))
    exact False.elim (arith_660 x h.zero h.square g0 g1)

private theorem arith_661 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (22 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_661 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25913, false), (25776, false), (25938, true)] := by
  refine if hc : Holds (assignment x) [(25913, false), (25776, false), (25938, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25913, false) ∈ [(25913, false), (25776, false), (25938, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25913, false), (25776, false), (25938, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25938, true) ∈ [(25913, false), (25776, false), (25938, true)])))
    exact False.elim (arith_661 x g0 g1 g2)

private theorem arith_662 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (22 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (23 : Int)) : False := by
  omega

theorem clause_662 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25913, false), (25777, false), (25941, true)] := by
  refine if hc : Holds (assignment x) [(25913, false), (25777, false), (25941, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25913, false) ∈ [(25913, false), (25777, false), (25941, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25777, false) ∈ [(25913, false), (25777, false), (25941, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25941, true) ∈ [(25913, false), (25777, false), (25941, true)])))
    exact False.elim (arith_662 x g0 g1 g2)

private theorem arith_663 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (22 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_663 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25913, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25913, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25913, false) ∈ [(25913, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25913, false), (25785, false)])))
    exact False.elim (arith_663 x h.zero h.square g0 g1)

private theorem arith_664 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (21 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (21 : Int)) : False := by
  omega

theorem clause_664 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25915, false), (25776, false), (25940, true)] := by
  refine if hc : Holds (assignment x) [(25915, false), (25776, false), (25940, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (21 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25915, false) ∈ [(25915, false), (25776, false), (25940, true)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25776, false) ∈ [(25915, false), (25776, false), (25940, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) ≠ (21 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25940, true) ∈ [(25915, false), (25776, false), (25940, true)])))
    exact False.elim (arith_664 x g0 g1 g2)

private theorem arith_665 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (21 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_665 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25915, false), (25780, false)] := by
  refine if hc : Holds (assignment x) [(25915, false), (25780, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (21 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25915, false) ∈ [(25915, false), (25780, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25780, false) ∈ [(25915, false), (25780, false)])))
    exact False.elim (arith_665 x h.zero h.square g0 g1)

private theorem arith_666 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (21 : Int)) (g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_666 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25915, false), (25785, false)] := by
  refine if hc : Holds (assignment x) [(25915, false), (25785, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int)) = (21 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25915, false) ∈ [(25915, false), (25785, false)])))
    have g1 : (((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25785, false) ∈ [(25915, false), (25785, false)])))
    exact False.elim (arith_666 x h.zero h.square g0 g1)

private theorem arith_667 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (9 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int)) : False := by
  omega

theorem clause_667 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25949, true), (25924, false), (25786, false)] := by
  refine if hc : Holds (assignment x) [(25949, true), (25924, false), (25786, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (9 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25949, true) ∈ [(25949, true), (25924, false), (25786, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25924, false) ∈ [(25949, true), (25924, false), (25786, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25786, false) ∈ [(25949, true), (25924, false), (25786, false)])))
    exact False.elim (arith_667 x g0 g1 g2)

private theorem arith_668 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (10 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (1 : Int)) : False := by
  omega

theorem clause_668 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25954, true), (25924, false), (25787, false)] := by
  refine if hc : Holds (assignment x) [(25954, true), (25924, false), (25787, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25954, true) ∈ [(25954, true), (25924, false), (25787, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25924, false) ∈ [(25954, true), (25924, false), (25787, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25787, false) ∈ [(25954, true), (25924, false), (25787, false)])))
    exact False.elim (arith_668 x g0 g1 g2)

private theorem arith_669 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (13 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_669 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25955, true), (25924, false), (25790, false)] := by
  refine if hc : Holds (assignment x) [(25955, true), (25924, false), (25790, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25955, true) ∈ [(25955, true), (25924, false), (25790, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25924, false) ∈ [(25955, true), (25924, false), (25790, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25790, false) ∈ [(25955, true), (25924, false), (25790, false)])))
    exact False.elim (arith_669 x g0 g1 g2)

private theorem arith_670 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (18 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (9 : Int)) : False := by
  omega

theorem clause_670 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25959, true), (25924, false), (25793, false)] := by
  refine if hc : Holds (assignment x) [(25959, true), (25924, false), (25793, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25959, true) ∈ [(25959, true), (25924, false), (25793, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25924, false) ∈ [(25959, true), (25924, false), (25793, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25793, false) ∈ [(25959, true), (25924, false), (25793, false)])))
    exact False.elim (arith_670 x g0 g1 g2)

private theorem arith_671 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_671 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25924, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25924, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25924, false) ∈ [(25924, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25924, false), (25795, false)])))
    exact False.elim (arith_671 x h.zero h.square g0 g1)

private theorem arith_672 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (12 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_672 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25925, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25925, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25925, false) ∈ [(25925, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25925, false), (25795, false)])))
    exact False.elim (arith_672 x h.zero h.square g0 g1)

private theorem arith_673 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (16 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_673 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25926, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25926, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25926, false) ∈ [(25926, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25926, false), (25795, false)])))
    exact False.elim (arith_673 x h.zero h.square g0 g1)

private theorem arith_674 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (10 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int)) : False := by
  omega

theorem clause_674 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25954, true), (25929, false), (25786, false)] := by
  refine if hc : Holds (assignment x) [(25954, true), (25929, false), (25786, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (10 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25954, true) ∈ [(25954, true), (25929, false), (25786, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25929, false) ∈ [(25954, true), (25929, false), (25786, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25786, false) ∈ [(25954, true), (25929, false), (25786, false)])))
    exact False.elim (arith_674 x g0 g1 g2)

private theorem arith_675 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (11 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (1 : Int)) : False := by
  omega

theorem clause_675 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25957, true), (25929, false), (25787, false)] := by
  refine if hc : Holds (assignment x) [(25957, true), (25929, false), (25787, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (11 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25957, true) ∈ [(25957, true), (25929, false), (25787, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25929, false) ∈ [(25957, true), (25929, false), (25787, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25787, false) ∈ [(25957, true), (25929, false), (25787, false)])))
    exact False.elim (arith_675 x g0 g1 g2)

private theorem arith_676 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (14 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (4 : Int)) : False := by
  omega

theorem clause_676 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25929, false), (25958, true), (25790, false)] := by
  refine if hc : Holds (assignment x) [(25929, false), (25958, true), (25790, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25929, false) ∈ [(25929, false), (25958, true), (25790, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25958, true) ∈ [(25929, false), (25958, true), (25790, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25790, false) ∈ [(25929, false), (25958, true), (25790, false)])))
    exact False.elim (arith_676 x g0 g1 g2)

private theorem arith_677 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_677 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25929, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25929, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25929, false) ∈ [(25929, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25929, false), (25795, false)])))
    exact False.elim (arith_677 x h.zero h.square g0 g1)

private theorem arith_678 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (13 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (13 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int)) : False := by
  omega

theorem clause_678 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25930, false), (25955, true), (25786, false)] := by
  refine if hc : Holds (assignment x) [(25930, false), (25955, true), (25786, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25930, false) ∈ [(25930, false), (25955, true), (25786, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (13 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25955, true) ∈ [(25930, false), (25955, true), (25786, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25786, false) ∈ [(25930, false), (25955, true), (25786, false)])))
    exact False.elim (arith_678 x g0 g1 g2)

private theorem arith_679 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (13 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (14 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (1 : Int)) : False := by
  omega

theorem clause_679 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25930, false), (25958, true), (25787, false)] := by
  refine if hc : Holds (assignment x) [(25930, false), (25958, true), (25787, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25930, false) ∈ [(25930, false), (25958, true), (25787, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25958, true) ∈ [(25930, false), (25958, true), (25787, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25787, false) ∈ [(25930, false), (25958, true), (25787, false)])))
    exact False.elim (arith_679 x g0 g1 g2)

private theorem arith_680 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (13 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_680 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25930, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25930, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25930, false) ∈ [(25930, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25930, false), (25795, false)])))
    exact False.elim (arith_680 x h.zero h.square g0 g1)

private theorem arith_681 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (17 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_681 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25931, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25931, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25931, false) ∈ [(25931, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25931, false), (25795, false)])))
    exact False.elim (arith_681 x h.zero h.square g0 g1)

private theorem arith_682 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (11 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_682 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25932, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25932, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25932, false) ∈ [(25932, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25932, false), (25795, false)])))
    exact False.elim (arith_682 x h.zero h.square g0 g1)

private theorem arith_683 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (14 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_683 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25933, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25933, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25933, false) ∈ [(25933, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25933, false), (25795, false)])))
    exact False.elim (arith_683 x h.zero h.square g0 g1)

private theorem arith_684 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (18 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (18 : Int)) (g2 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int)) : False := by
  omega

theorem clause_684 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25959, true), (25934, false), (25786, false)] := by
  refine if hc : Holds (assignment x) [(25959, true), (25934, false), (25786, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25959, true) ∈ [(25959, true), (25934, false), (25786, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25934, false) ∈ [(25959, true), (25934, false), (25786, false)])))
    have g2 : (((x 4 * x 4 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25786, false) ∈ [(25959, true), (25934, false), (25786, false)])))
    exact False.elim (arith_684 x g0 g1 g2)

private theorem arith_685 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (18 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_685 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25934, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25934, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25934, false) ∈ [(25934, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25934, false), (25795, false)])))
    exact False.elim (arith_685 x h.zero h.square g0 g1)

private theorem arith_686 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (15 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_686 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25935, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25935, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25935, false) ∈ [(25935, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25935, false), (25795, false)])))
    exact False.elim (arith_686 x h.zero h.square g0 g1)

private theorem arith_687 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (19 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_687 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25936, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25936, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (19 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25936, false) ∈ [(25936, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25936, false), (25795, false)])))
    exact False.elim (arith_687 x h.zero h.square g0 g1)

private theorem arith_688 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (20 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_688 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25937, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25937, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (20 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25937, false) ∈ [(25937, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25937, false), (25795, false)])))
    exact False.elim (arith_688 x h.zero h.square g0 g1)

private theorem arith_689 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (22 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_689 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25938, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25938, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25938, false) ∈ [(25938, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25938, false), (25795, false)])))
    exact False.elim (arith_689 x h.zero h.square g0 g1)

private theorem arith_690 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (21 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_690 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25940, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25940, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (21 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25940, false) ∈ [(25940, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25940, false), (25795, false)])))
    exact False.elim (arith_690 x h.zero h.square g0 g1)

private theorem arith_691 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (23 : Int)) (g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_691 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25941, false), (25795, false)] := by
  refine if hc : Holds (assignment x) [(25941, false), (25795, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25941, false) ∈ [(25941, false), (25795, false)])))
    have g1 : (((x 4 * x 4 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25795, false) ∈ [(25941, false), (25795, false)])))
    exact False.elim (arith_691 x h.zero h.square g0 g1)

private theorem arith_692 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (9 : Int)) (g1 : (((x 5 * x 5 : Nat) : Int)) = (9 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_692 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25949, false), (25803, false), (25984, true)] := by
  refine if hc : Holds (assignment x) [(25949, false), (25803, false), (25984, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25949, false) ∈ [(25949, false), (25803, false), (25984, true)])))
    have g1 : (((x 5 * x 5 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25803, false) ∈ [(25949, false), (25803, false), (25984, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25984, true) ∈ [(25949, false), (25803, false), (25984, true)])))
    exact False.elim (arith_692 x g0 g1 g2)

private theorem arith_693 (x : Fin 12 → Nat)
    (g0 : (((x 5 * x 5 : Nat) : Int)) = (4 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (10 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_693 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25800, false), (25954, false), (25983, true)] := by
  refine if hc : Holds (assignment x) [(25800, false), (25954, false), (25983, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 5 * x 5 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25800, false) ∈ [(25800, false), (25954, false), (25983, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (10 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25954, false) ∈ [(25800, false), (25954, false), (25983, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25983, true) ∈ [(25800, false), (25954, false), (25983, true)])))
    exact False.elim (arith_693 x g0 g1 g2)

private theorem arith_694 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (13 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (14 : Int)) (g2 : (((x 5 * x 5 : Nat) : Int)) = (1 : Int)) : False := by
  omega

theorem clause_694 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25955, false), (25983, true), (25797, false)] := by
  refine if hc : Holds (assignment x) [(25955, false), (25983, true), (25797, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (13 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25955, false) ∈ [(25955, false), (25983, true), (25797, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25983, true) ∈ [(25955, false), (25983, true), (25797, false)])))
    have g2 : (((x 5 * x 5 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25797, false) ∈ [(25955, false), (25983, true), (25797, false)])))
    exact False.elim (arith_694 x g0 g1 g2)

private theorem arith_695 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (11 : Int)) (g1 : (((x 5 * x 5 : Nat) : Int)) = (1 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (12 : Int)) : False := by
  omega

theorem clause_695 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25957, false), (25797, false), (25975, true)] := by
  refine if hc : Holds (assignment x) [(25957, false), (25797, false), (25975, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (11 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25957, false) ∈ [(25957, false), (25797, false), (25975, true)])))
    have g1 : (((x 5 * x 5 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25797, false) ∈ [(25957, false), (25797, false), (25975, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (12 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25975, true) ∈ [(25957, false), (25797, false), (25975, true)])))
    exact False.elim (arith_695 x g0 g1 g2)

private theorem arith_696 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (14 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (14 : Int)) (g2 : (((x 5 * x 5 : Nat) : Int)) = (0 : Int)) : False := by
  omega

theorem clause_696 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25958, false), (25983, true), (25796, false)] := by
  refine if hc : Holds (assignment x) [(25958, false), (25983, true), (25796, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25958, false) ∈ [(25958, false), (25983, true), (25796, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25983, true) ∈ [(25958, false), (25983, true), (25796, false)])))
    have g2 : (((x 5 * x 5 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25796, false) ∈ [(25958, false), (25983, true), (25796, false)])))
    exact False.elim (arith_696 x g0 g1 g2)

private theorem arith_697 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (18 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (18 : Int)) (g2 : (((x 5 * x 5 : Nat) : Int)) = (0 : Int)) : False := by
  omega

theorem clause_697 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25959, false), (25984, true), (25796, false)] := by
  refine if hc : Holds (assignment x) [(25959, false), (25984, true), (25796, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25959, false) ∈ [(25959, false), (25984, true), (25796, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25984, true) ∈ [(25959, false), (25984, true), (25796, false)])))
    have g2 : (((x 5 * x 5 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25796, false) ∈ [(25959, false), (25984, true), (25796, false)])))
    exact False.elim (arith_697 x g0 g1 g2)

private theorem arith_698 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (12 : Int)) (g1 : (((x 6 * x 6 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (16 : Int)) : False := by
  omega

theorem clause_698 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25975, false), (25810, false), (26001, true)] := by
  refine if hc : Holds (assignment x) [(25975, false), (25810, false), (26001, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25975, false) ∈ [(25975, false), (25810, false), (26001, true)])))
    have g1 : (((x 6 * x 6 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25810, false) ∈ [(25975, false), (25810, false), (26001, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (16 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26001, true) ∈ [(25975, false), (25810, false), (26001, true)])))
    exact False.elim (arith_698 x g0 g1 g2)

private theorem arith_699 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (12 : Int)) (g1 : (((x 6 * x 6 : Nat) : Int)) = (9 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (21 : Int)) : False := by
  omega

theorem clause_699 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25975, false), (25813, false), (26015, true)] := by
  refine if hc : Holds (assignment x) [(25975, false), (25813, false), (26015, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25975, false) ∈ [(25975, false), (25813, false), (26015, true)])))
    have g1 : (((x 6 * x 6 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25813, false) ∈ [(25975, false), (25813, false), (26015, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (21 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26015, true) ∈ [(25975, false), (25813, false), (26015, true)])))
    exact False.elim (arith_699 x g0 g1 g2)

private theorem arith_700 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : (((x 6 * x 6 : Nat) : Int)) = (16 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (12 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_700 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25815, false), (25975, false)] := by
  refine if hc : Holds (assignment x) [(25815, false), (25975, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 6 * x 6 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25815, false) ∈ [(25815, false), (25975, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (12 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25975, false) ∈ [(25815, false), (25975, false)])))
    exact False.elim (arith_700 x h.zero h.square g0 g1)

private theorem arith_701 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (14 : Int)) (g1 : (((x 6 * x 6 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int)) : False := by
  omega

theorem clause_701 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26008, true), (25806, false), (25983, false)] := by
  refine if hc : Holds (assignment x) [(26008, true), (25806, false), (25983, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26008, true) ∈ [(26008, true), (25806, false), (25983, false)])))
    have g1 : (((x 6 * x 6 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25806, false) ∈ [(26008, true), (25806, false), (25983, false)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25983, false) ∈ [(26008, true), (25806, false), (25983, false)])))
    exact False.elim (arith_701 x g0 g1 g2)

private theorem arith_702 (x : Fin 12 → Nat)
    (g0 : (((x 6 * x 6 : Nat) : Int)) = (4 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_702 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25810, false), (25983, false), (26009, true)] := by
  refine if hc : Holds (assignment x) [(25810, false), (25983, false), (26009, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 6 * x 6 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25810, false) ∈ [(25810, false), (25983, false), (26009, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25983, false) ∈ [(25810, false), (25983, false), (26009, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26009, true) ∈ [(25810, false), (25983, false), (26009, true)])))
    exact False.elim (arith_702 x g0 g1 g2)

private theorem arith_703 (x : Fin 12 → Nat)
    (g0 : (((x 6 * x 6 : Nat) : Int)) = (9 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (23 : Int)) : False := by
  omega

theorem clause_703 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25813, false), (25983, false), (26016, true)] := by
  refine if hc : Holds (assignment x) [(25813, false), (25983, false), (26016, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 6 * x 6 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25813, false) ∈ [(25813, false), (25983, false), (26016, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25983, false) ∈ [(25813, false), (25983, false), (26016, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26016, true) ∈ [(25813, false), (25983, false), (26016, true)])))
    exact False.elim (arith_703 x g0 g1 g2)

private theorem arith_704 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : (((x 6 * x 6 : Nat) : Int)) = (16 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_704 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25815, false), (25983, false)] := by
  refine if hc : Holds (assignment x) [(25815, false), (25983, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 6 * x 6 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25815, false) ∈ [(25815, false), (25983, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25983, false) ∈ [(25815, false), (25983, false)])))
    exact False.elim (arith_704 x h.zero h.square g0 g1)

private theorem arith_705 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (18 : Int)) (g1 : (((x 6 * x 6 : Nat) : Int)) = (4 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_705 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25984, false), (25810, false), (26013, true)] := by
  refine if hc : Holds (assignment x) [(25984, false), (25810, false), (26013, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25984, false) ∈ [(25984, false), (25810, false), (26013, true)])))
    have g1 : (((x 6 * x 6 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25810, false) ∈ [(25984, false), (25810, false), (26013, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26013, true) ∈ [(25984, false), (25810, false), (26013, true)])))
    exact False.elim (arith_705 x g0 g1 g2)

private theorem arith_706 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : (((x 6 * x 6 : Nat) : Int)) = (9 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (18 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_706 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25813, false), (25984, false)] := by
  refine if hc : Holds (assignment x) [(25813, false), (25984, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 6 * x 6 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25813, false) ∈ [(25813, false), (25984, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25984, false) ∈ [(25813, false), (25984, false)])))
    exact False.elim (arith_706 x h.zero h.square g0 g1)

private theorem arith_707 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : (((x 6 * x 6 : Nat) : Int)) = (16 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (18 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_707 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25815, false), (25984, false)] := by
  refine if hc : Holds (assignment x) [(25815, false), (25984, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 6 * x 6 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25815, false) ∈ [(25815, false), (25984, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25984, false) ∈ [(25815, false), (25984, false)])))
    exact False.elim (arith_707 x h.zero h.square g0 g1)

private theorem arith_708 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (16 : Int)) (g1 : (((x 7 * x 7 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_708 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26001, false), (25825, false)] := by
  refine if hc : Holds (assignment x) [(26001, false), (25825, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26001, false) ∈ [(26001, false), (25825, false)])))
    have g1 : (((x 7 * x 7 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25825, false) ∈ [(26001, false), (25825, false)])))
    exact False.elim (arith_708 x h.zero h.square g0 g1)

private theorem arith_709 (x : Fin 12 → Nat)
    (g0 : (((x 7 * x 7 : Nat) : Int)) = (0 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) ≠ (14 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int)) : False := by
  omega

theorem clause_709 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25816, false), (26033, true), (26008, false)] := by
  refine if hc : Holds (assignment x) [(25816, false), (26033, true), (26008, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25816, false) ∈ [(25816, false), (26033, true), (26008, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26033, true) ∈ [(25816, false), (26033, true), (26008, false)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26008, false) ∈ [(25816, false), (26033, true), (26008, false)])))
    exact False.elim (arith_709 x g0 g1 g2)

private theorem arith_710 (x : Fin 12 → Nat)
    (g0 : (((x 7 * x 7 : Nat) : Int)) = (1 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) ≠ (15 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int)) : False := by
  omega

theorem clause_710 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25817, false), (26035, true), (26008, false)] := by
  refine if hc : Holds (assignment x) [(25817, false), (26035, true), (26008, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25817, false) ∈ [(25817, false), (26035, true), (26008, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26035, true) ∈ [(25817, false), (26035, true), (26008, false)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26008, false) ∈ [(25817, false), (26035, true), (26008, false)])))
    exact False.elim (arith_710 x g0 g1 g2)

private theorem arith_711 (x : Fin 12 → Nat)
    (g0 : (((x 7 * x 7 : Nat) : Int)) = (4 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) ≠ (18 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int)) : False := by
  omega

theorem clause_711 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25820, false), (26034, true), (26008, false)] := by
  refine if hc : Holds (assignment x) [(25820, false), (26034, true), (26008, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25820, false) ∈ [(25820, false), (26034, true), (26008, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26034, true) ∈ [(25820, false), (26034, true), (26008, false)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26008, false) ∈ [(25820, false), (26034, true), (26008, false)])))
    exact False.elim (arith_711 x g0 g1 g2)

private theorem arith_712 (x : Fin 12 → Nat)
    (g0 : (((x 7 * x 7 : Nat) : Int)) = (9 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) ≠ (23 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int)) : False := by
  omega

theorem clause_712 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25823, false), (26041, true), (26008, false)] := by
  refine if hc : Holds (assignment x) [(25823, false), (26041, true), (26008, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25823, false) ∈ [(25823, false), (26041, true), (26008, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26041, true) ∈ [(25823, false), (26041, true), (26008, false)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26008, false) ∈ [(25823, false), (26041, true), (26008, false)])))
    exact False.elim (arith_712 x g0 g1 g2)

private theorem arith_713 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : (((x 7 * x 7 : Nat) : Int)) = (16 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_713 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25825, false), (26008, false)] := by
  refine if hc : Holds (assignment x) [(25825, false), (26008, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25825, false) ∈ [(25825, false), (26008, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26008, false) ∈ [(25825, false), (26008, false)])))
    exact False.elim (arith_713 x h.zero h.square g0 g1)

private theorem arith_714 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : (((x 7 * x 7 : Nat) : Int)) = (16 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (18 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_714 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25825, false), (26009, false)] := by
  refine if hc : Holds (assignment x) [(25825, false), (26009, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 7 * x 7 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25825, false) ∈ [(25825, false), (26009, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26009, false) ∈ [(25825, false), (26009, false)])))
    exact False.elim (arith_714 x h.zero h.square g0 g1)

private theorem arith_715 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (22 : Int)) (g1 : (((x 7 * x 7 : Nat) : Int)) = (16 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_715 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26013, false), (25825, false)] := by
  refine if hc : Holds (assignment x) [(26013, false), (25825, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26013, false) ∈ [(26013, false), (25825, false)])))
    have g1 : (((x 7 * x 7 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25825, false) ∈ [(26013, false), (25825, false)])))
    exact False.elim (arith_715 x h.zero h.square g0 g1)

private theorem arith_716 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (21 : Int)) (g1 : (((x 7 * x 7 : Nat) : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_716 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26015, false), (25823, false)] := by
  refine if hc : Holds (assignment x) [(26015, false), (25823, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (21 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26015, false) ∈ [(26015, false), (25823, false)])))
    have g1 : (((x 7 * x 7 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25823, false) ∈ [(26015, false), (25823, false)])))
    exact False.elim (arith_716 x h.zero h.square g0 g1)

private theorem arith_717 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (23 : Int)) (g1 : (((x 7 * x 7 : Nat) : Int)) = (9 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_717 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26016, false), (25823, false)] := by
  refine if hc : Holds (assignment x) [(26016, false), (25823, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26016, false) ∈ [(26016, false), (25823, false)])))
    have g1 : (((x 7 * x 7 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25823, false) ∈ [(26016, false), (25823, false)])))
    exact False.elim (arith_717 x h.zero h.square g0 g1)

private theorem arith_718 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (14 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int)) : False := by
  omega

theorem clause_718 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26033, false), (26026, false)] := by
  refine if hc : Holds (assignment x) [(26033, false), (26026, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26033, false) ∈ [(26033, false), (26026, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26026, false) ∈ [(26033, false), (26026, false)])))
    exact False.elim (arith_718 x g0 g1)

private theorem arith_719 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (18 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int)) : False := by
  omega

theorem clause_719 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26034, false), (26026, false)] := by
  refine if hc : Holds (assignment x) [(26034, false), (26026, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26034, false) ∈ [(26034, false), (26026, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26026, false) ∈ [(26034, false), (26026, false)])))
    exact False.elim (arith_719 x g0 g1)

private theorem arith_720 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (15 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int)) : False := by
  omega

theorem clause_720 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26035, false), (26026, false)] := by
  refine if hc : Holds (assignment x) [(26035, false), (26026, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26035, false) ∈ [(26035, false), (26026, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26026, false) ∈ [(26035, false), (26026, false)])))
    exact False.elim (arith_720 x g0 g1)

private theorem arith_721 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (23 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int)) : False := by
  omega

theorem clause_721 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26041, false), (26026, false)] := by
  refine if hc : Holds (assignment x) [(26041, false), (26026, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26041, false) ∈ [(26041, false), (26026, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26026, false) ∈ [(26041, false), (26026, false)])))
    exact False.elim (arith_721 x g0 g1)

private theorem arith_722 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (17 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_722 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26031, false), (25826, false), (26056, true)] := by
  refine if hc : Holds (assignment x) [(26031, false), (25826, false), (26056, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26031, false) ∈ [(26031, false), (25826, false), (26056, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(26031, false), (25826, false), (26056, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26056, true) ∈ [(26031, false), (25826, false), (26056, true)])))
    exact False.elim (arith_722 x g0 g1 g2)

private theorem arith_723 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (14 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_723 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26033, false), (25826, false), (26058, true)] := by
  refine if hc : Holds (assignment x) [(26033, false), (25826, false), (26058, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26033, false) ∈ [(26033, false), (25826, false), (26058, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(26033, false), (25826, false), (26058, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26058, true) ∈ [(26033, false), (25826, false), (26058, true)])))
    exact False.elim (arith_723 x g0 g1 g2)

private theorem arith_724 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (18 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_724 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26034, false), (25826, false), (26059, true)] := by
  refine if hc : Holds (assignment x) [(26034, false), (25826, false), (26059, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26034, false) ∈ [(26034, false), (25826, false), (26059, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(26034, false), (25826, false), (26059, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26059, true) ∈ [(26034, false), (25826, false), (26059, true)])))
    exact False.elim (arith_724 x g0 g1 g2)

private theorem arith_725 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (15 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_725 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26035, false), (25826, false), (26060, true)] := by
  refine if hc : Holds (assignment x) [(26035, false), (25826, false), (26060, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26035, false) ∈ [(26035, false), (25826, false), (26060, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(26035, false), (25826, false), (26060, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26060, true) ∈ [(26035, false), (25826, false), (26060, true)])))
    exact False.elim (arith_725 x g0 g1 g2)

private theorem arith_726 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (20 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (20 : Int)) : False := by
  omega

theorem clause_726 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26037, false), (25826, false), (26062, true)] := by
  refine if hc : Holds (assignment x) [(26037, false), (25826, false), (26062, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (20 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26037, false) ∈ [(26037, false), (25826, false), (26062, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(26037, false), (25826, false), (26062, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (20 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26062, true) ∈ [(26037, false), (25826, false), (26062, true)])))
    exact False.elim (arith_726 x g0 g1 g2)

private theorem arith_727 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (22 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_727 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26038, false), (25826, false), (26063, true)] := by
  refine if hc : Holds (assignment x) [(26038, false), (25826, false), (26063, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26038, false) ∈ [(26038, false), (25826, false), (26063, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(26038, false), (25826, false), (26063, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26063, true) ∈ [(26038, false), (25826, false), (26063, true)])))
    exact False.elim (arith_727 x g0 g1 g2)

private theorem arith_728 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (23 : Int)) (g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (23 : Int)) : False := by
  omega

theorem clause_728 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26041, false), (25826, false), (26066, true)] := by
  refine if hc : Holds (assignment x) [(26041, false), (25826, false), (26066, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26041, false) ∈ [(26041, false), (25826, false), (26066, true)])))
    have g1 : (((x 8 * x 8 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25826, false) ∈ [(26041, false), (25826, false), (26066, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26066, true) ∈ [(26041, false), (25826, false), (26066, true)])))
    exact False.elim (arith_728 x g0 g1 g2)

private theorem arith_729 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (17 : Int)) (g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_729 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26056, false), (25836, false), (26081, true)] := by
  refine if hc : Holds (assignment x) [(26056, false), (25836, false), (26081, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26056, false) ∈ [(26056, false), (25836, false), (26081, true)])))
    have g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25836, false) ∈ [(26056, false), (25836, false), (26081, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26081, true) ∈ [(26056, false), (25836, false), (26081, true)])))
    exact False.elim (arith_729 x g0 g1 g2)

private theorem arith_730 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (14 : Int)) (g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_730 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26058, false), (25836, false), (26083, true)] := by
  refine if hc : Holds (assignment x) [(26058, false), (25836, false), (26083, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26058, false) ∈ [(26058, false), (25836, false), (26083, true)])))
    have g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25836, false) ∈ [(26058, false), (25836, false), (26083, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26083, true) ∈ [(26058, false), (25836, false), (26083, true)])))
    exact False.elim (arith_730 x g0 g1 g2)

private theorem arith_731 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (18 : Int)) (g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_731 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26059, false), (25836, false), (26084, true)] := by
  refine if hc : Holds (assignment x) [(26059, false), (25836, false), (26084, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26059, false) ∈ [(26059, false), (25836, false), (26084, true)])))
    have g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25836, false) ∈ [(26059, false), (25836, false), (26084, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26084, true) ∈ [(26059, false), (25836, false), (26084, true)])))
    exact False.elim (arith_731 x g0 g1 g2)

private theorem arith_732 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (15 : Int)) (g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_732 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26060, false), (25836, false), (26085, true)] := by
  refine if hc : Holds (assignment x) [(26060, false), (25836, false), (26085, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26060, false) ∈ [(26060, false), (25836, false), (26085, true)])))
    have g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25836, false) ∈ [(26060, false), (25836, false), (26085, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26085, true) ∈ [(26060, false), (25836, false), (26085, true)])))
    exact False.elim (arith_732 x g0 g1 g2)

private theorem arith_733 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (20 : Int)) (g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (20 : Int)) : False := by
  omega

theorem clause_733 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26062, false), (25836, false), (26087, true)] := by
  refine if hc : Holds (assignment x) [(26062, false), (25836, false), (26087, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (20 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26062, false) ∈ [(26062, false), (25836, false), (26087, true)])))
    have g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25836, false) ∈ [(26062, false), (25836, false), (26087, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (20 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26087, true) ∈ [(26062, false), (25836, false), (26087, true)])))
    exact False.elim (arith_733 x g0 g1 g2)

private theorem arith_734 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (22 : Int)) (g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_734 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26063, false), (25836, false), (26088, true)] := by
  refine if hc : Holds (assignment x) [(26063, false), (25836, false), (26088, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26063, false) ∈ [(26063, false), (25836, false), (26088, true)])))
    have g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25836, false) ∈ [(26063, false), (25836, false), (26088, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26088, true) ∈ [(26063, false), (25836, false), (26088, true)])))
    exact False.elim (arith_734 x g0 g1 g2)

private theorem arith_735 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (23 : Int)) (g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (23 : Int)) : False := by
  omega

theorem clause_735 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26066, false), (25836, false), (26091, true)] := by
  refine if hc : Holds (assignment x) [(26066, false), (25836, false), (26091, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26066, false) ∈ [(26066, false), (25836, false), (26091, true)])))
    have g1 : (((x 9 * x 9 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25836, false) ∈ [(26066, false), (25836, false), (26091, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26091, true) ∈ [(26066, false), (25836, false), (26091, true)])))
    exact False.elim (arith_735 x g0 g1 g2)

private theorem arith_736 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (17 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_736 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26081, false), (25846, false), (26106, true)] := by
  refine if hc : Holds (assignment x) [(26081, false), (25846, false), (26106, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26081, false) ∈ [(26081, false), (25846, false), (26106, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25846, false) ∈ [(26081, false), (25846, false), (26106, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26106, true) ∈ [(26081, false), (25846, false), (26106, true)])))
    exact False.elim (arith_736 x g0 g1 g2)

private theorem arith_737 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_737 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26083, false), (25846, false), (26108, true)] := by
  refine if hc : Holds (assignment x) [(26083, false), (25846, false), (26108, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26083, false) ∈ [(26083, false), (25846, false), (26108, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25846, false) ∈ [(26083, false), (25846, false), (26108, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26108, true) ∈ [(26083, false), (25846, false), (26108, true)])))
    exact False.elim (arith_737 x g0 g1 g2)

private theorem arith_738 (x : Fin 12 → Nat)
    (g0 : (((x 10 * x 10 : Nat) : Int)) = (1 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_738 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25847, false), (26083, false), (26110, true)] := by
  refine if hc : Holds (assignment x) [(25847, false), (26083, false), (26110, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 10 * x 10 : Nat) : Int)) = (1 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25847, false) ∈ [(25847, false), (26083, false), (26110, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26083, false) ∈ [(25847, false), (26083, false), (26110, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26110, true) ∈ [(25847, false), (26083, false), (26110, true)])))
    exact False.elim (arith_738 x g0 g1 g2)

private theorem arith_739 (x : Fin 12 → Nat)
    (g0 : (((x 10 * x 10 : Nat) : Int)) = (4 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_739 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25850, false), (26083, false), (26109, true)] := by
  refine if hc : Holds (assignment x) [(25850, false), (26083, false), (26109, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 10 * x 10 : Nat) : Int)) = (4 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25850, false) ∈ [(25850, false), (26083, false), (26109, true)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26083, false) ∈ [(25850, false), (26083, false), (26109, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26109, true) ∈ [(25850, false), (26083, false), (26109, true)])))
    exact False.elim (arith_739 x g0 g1 g2)

private theorem arith_740 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) = (9 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (23 : Int)) : False := by
  omega

theorem clause_740 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26083, false), (25853, false), (26116, true)] := by
  refine if hc : Holds (assignment x) [(26083, false), (25853, false), (26116, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26083, false) ∈ [(26083, false), (25853, false), (26116, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) = (9 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25853, false) ∈ [(26083, false), (25853, false), (26116, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26116, true) ∈ [(26083, false), (25853, false), (26116, true)])))
    exact False.elim (arith_740 x g0 g1 g2)

private theorem arith_741 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : (((x 10 * x 10 : Nat) : Int)) = (16 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_741 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25855, false), (26083, false)] := by
  refine if hc : Holds (assignment x) [(25855, false), (26083, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (((x 10 * x 10 : Nat) : Int)) = (16 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25855, false) ∈ [(25855, false), (26083, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26083, false) ∈ [(25855, false), (26083, false)])))
    exact False.elim (arith_741 x h.zero h.square g0 g1)

private theorem arith_742 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (18 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_742 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26084, false), (25846, false), (26109, true)] := by
  refine if hc : Holds (assignment x) [(26084, false), (25846, false), (26109, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26084, false) ∈ [(26084, false), (25846, false), (26109, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25846, false) ∈ [(26084, false), (25846, false), (26109, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26109, true) ∈ [(26084, false), (25846, false), (26109, true)])))
    exact False.elim (arith_742 x g0 g1 g2)

private theorem arith_743 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (15 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_743 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26085, false), (25846, false), (26110, true)] := by
  refine if hc : Holds (assignment x) [(26085, false), (25846, false), (26110, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26085, false) ∈ [(26085, false), (25846, false), (26110, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25846, false) ∈ [(26085, false), (25846, false), (26110, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26110, true) ∈ [(26085, false), (25846, false), (26110, true)])))
    exact False.elim (arith_743 x g0 g1 g2)

private theorem arith_744 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (20 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (20 : Int)) : False := by
  omega

theorem clause_744 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26087, false), (25846, false), (26112, true)] := by
  refine if hc : Holds (assignment x) [(26087, false), (25846, false), (26112, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (20 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26087, false) ∈ [(26087, false), (25846, false), (26112, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25846, false) ∈ [(26087, false), (25846, false), (26112, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (20 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26112, true) ∈ [(26087, false), (25846, false), (26112, true)])))
    exact False.elim (arith_744 x g0 g1 g2)

private theorem arith_745 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (22 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_745 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26088, false), (25846, false), (26113, true)] := by
  refine if hc : Holds (assignment x) [(26088, false), (25846, false), (26113, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26088, false) ∈ [(26088, false), (25846, false), (26113, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25846, false) ∈ [(26088, false), (25846, false), (26113, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26113, true) ∈ [(26088, false), (25846, false), (26113, true)])))
    exact False.elim (arith_745 x g0 g1 g2)

private theorem arith_746 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (23 : Int)) (g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (23 : Int)) : False := by
  omega

theorem clause_746 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26091, false), (25846, false), (26116, true)] := by
  refine if hc : Holds (assignment x) [(26091, false), (25846, false), (26116, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26091, false) ∈ [(26091, false), (25846, false), (26116, true)])))
    have g1 : (((x 10 * x 10 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25846, false) ∈ [(26091, false), (25846, false), (26116, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26116, true) ∈ [(26091, false), (25846, false), (26116, true)])))
    exact False.elim (arith_746 x g0 g1 g2)

private theorem arith_747 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (17 : Int)) (g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_747 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26106, false), (25856, false), (26134, true)] := by
  refine if hc : Holds (assignment x) [(26106, false), (25856, false), (26134, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26106, false) ∈ [(26106, false), (25856, false), (26134, true)])))
    have g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25856, false) ∈ [(26106, false), (25856, false), (26134, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26134, true) ∈ [(26106, false), (25856, false), (26134, true)])))
    exact False.elim (arith_747 x g0 g1 g2)

private theorem arith_748 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (14 : Int)) (g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_748 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26108, false), (25856, false), (26133, true)] := by
  refine if hc : Holds (assignment x) [(26108, false), (25856, false), (26133, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26108, false) ∈ [(26108, false), (25856, false), (26133, true)])))
    have g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25856, false) ∈ [(26108, false), (25856, false), (26133, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26133, true) ∈ [(26108, false), (25856, false), (26133, true)])))
    exact False.elim (arith_748 x g0 g1 g2)

private theorem arith_749 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (18 : Int)) (g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_749 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26109, false), (25856, false), (26137, true)] := by
  refine if hc : Holds (assignment x) [(26109, false), (25856, false), (26137, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26109, false) ∈ [(26109, false), (25856, false), (26137, true)])))
    have g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25856, false) ∈ [(26109, false), (25856, false), (26137, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26137, true) ∈ [(26109, false), (25856, false), (26137, true)])))
    exact False.elim (arith_749 x g0 g1 g2)

private theorem arith_750 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (15 : Int)) (g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_750 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26110, false), (25856, false), (26136, true)] := by
  refine if hc : Holds (assignment x) [(26110, false), (25856, false), (26136, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26110, false) ∈ [(26110, false), (25856, false), (26136, true)])))
    have g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25856, false) ∈ [(26110, false), (25856, false), (26136, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26136, true) ∈ [(26110, false), (25856, false), (26136, true)])))
    exact False.elim (arith_750 x g0 g1 g2)

private theorem arith_751 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (20 : Int)) (g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (20 : Int)) : False := by
  omega

theorem clause_751 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26112, false), (25856, false), (26131, true)] := by
  refine if hc : Holds (assignment x) [(26112, false), (25856, false), (26131, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (20 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26112, false) ∈ [(26112, false), (25856, false), (26131, true)])))
    have g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25856, false) ∈ [(26112, false), (25856, false), (26131, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (20 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26131, true) ∈ [(26112, false), (25856, false), (26131, true)])))
    exact False.elim (arith_751 x g0 g1 g2)

private theorem arith_752 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (22 : Int)) (g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_752 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26113, false), (25856, false), (26138, true)] := by
  refine if hc : Holds (assignment x) [(26113, false), (25856, false), (26138, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26113, false) ∈ [(26113, false), (25856, false), (26138, true)])))
    have g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25856, false) ∈ [(26113, false), (25856, false), (26138, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26138, true) ∈ [(26113, false), (25856, false), (26138, true)])))
    exact False.elim (arith_752 x g0 g1 g2)

private theorem arith_753 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (23 : Int)) (g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (23 : Int)) : False := by
  omega

theorem clause_753 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26116, false), (25856, false), (26140, true)] := by
  refine if hc : Holds (assignment x) [(26116, false), (25856, false), (26140, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26116, false) ∈ [(26116, false), (25856, false), (26140, true)])))
    have g1 : (((x 11 * x 11 : Nat) : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (25856, false) ∈ [(26116, false), (25856, false), (26140, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26140, true) ∈ [(26116, false), (25856, false), (26140, true)])))
    exact False.elim (arith_753 x g0 g1 g2)

private theorem arith_754 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (20 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (20 : Int)) : False := by
  omega

theorem clause_754 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26131, false), (354, false), (26160, true)] := by
  refine if hc : Holds (assignment x) [(26131, false), (354, false), (26160, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (20 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26131, false) ∈ [(26131, false), (354, false), (26160, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(26131, false), (354, false), (26160, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (20 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26160, true) ∈ [(26131, false), (354, false), (26160, true)])))
    exact False.elim (arith_754 x g0 g1 g2)

private theorem arith_755 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (14 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (14 : Int)) : False := by
  omega

theorem clause_755 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26133, false), (354, false), (26154, true)] := by
  refine if hc : Holds (assignment x) [(26133, false), (354, false), (26154, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26133, false) ∈ [(26133, false), (354, false), (26154, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(26133, false), (354, false), (26154, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (14 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26154, true) ∈ [(26133, false), (354, false), (26154, true)])))
    exact False.elim (arith_755 x g0 g1 g2)

private theorem arith_756 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (17 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (17 : Int)) : False := by
  omega

theorem clause_756 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26134, false), (354, false), (26162, true)] := by
  refine if hc : Holds (assignment x) [(26134, false), (354, false), (26162, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26134, false) ∈ [(26134, false), (354, false), (26162, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(26134, false), (354, false), (26162, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (17 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26162, true) ∈ [(26134, false), (354, false), (26162, true)])))
    exact False.elim (arith_756 x g0 g1 g2)

private theorem arith_757 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (15 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (15 : Int)) : False := by
  omega

theorem clause_757 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26136, false), (354, false), (26157, true)] := by
  refine if hc : Holds (assignment x) [(26136, false), (354, false), (26157, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26136, false) ∈ [(26136, false), (354, false), (26157, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(26136, false), (354, false), (26157, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (15 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26157, true) ∈ [(26136, false), (354, false), (26157, true)])))
    exact False.elim (arith_757 x g0 g1 g2)

private theorem arith_758 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (18 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (18 : Int)) : False := by
  omega

theorem clause_758 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26137, false), (354, false), (26159, true)] := by
  refine if hc : Holds (assignment x) [(26137, false), (354, false), (26159, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26137, false) ∈ [(26137, false), (354, false), (26159, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(26137, false), (354, false), (26159, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (18 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26159, true) ∈ [(26137, false), (354, false), (26159, true)])))
    exact False.elim (arith_758 x g0 g1 g2)

private theorem arith_759 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (22 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (22 : Int)) : False := by
  omega

theorem clause_759 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26138, false), (354, false), (26161, true)] := by
  refine if hc : Holds (assignment x) [(26138, false), (354, false), (26161, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26138, false) ∈ [(26138, false), (354, false), (26161, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(26138, false), (354, false), (26161, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (22 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26161, true) ∈ [(26138, false), (354, false), (26161, true)])))
    exact False.elim (arith_759 x g0 g1 g2)

private theorem arith_760 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (23 : Int)) (g1 : ((x 11 : Int)) = (0 : Int)) (g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (23 : Int)) : False := by
  omega

theorem clause_760 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26140, false), (354, false), (26165, true)] := by
  refine if hc : Holds (assignment x) [(26140, false), (354, false), (26165, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + ((x 11 * x 11 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26140, false) ∈ [(26140, false), (354, false), (26165, true)])))
    have g1 : ((x 11 : Int)) = (0 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (354, false) ∈ [(26140, false), (354, false), (26165, true)])))
    have g2 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (23 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26165, true) ∈ [(26140, false), (354, false), (26165, true)])))
    exact False.elim (arith_760 x g0 g1 g2)

private theorem arith_761 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (14 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int)) : False := by
  omega

theorem clause_761 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26154, false), (26166, false)] := by
  refine if hc : Holds (assignment x) [(26154, false), (26166, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (14 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26154, false) ∈ [(26154, false), (26166, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26166, false) ∈ [(26154, false), (26166, false)])))
    exact False.elim (arith_761 x g0 g1)

private theorem arith_762 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (15 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int)) : False := by
  omega

theorem clause_762 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26157, false), (26166, false)] := by
  refine if hc : Holds (assignment x) [(26157, false), (26166, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (15 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26157, false) ∈ [(26157, false), (26166, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26166, false) ∈ [(26157, false), (26166, false)])))
    exact False.elim (arith_762 x g0 g1)

private theorem arith_763 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (18 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int)) : False := by
  omega

theorem clause_763 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26159, false), (26166, false)] := by
  refine if hc : Holds (assignment x) [(26159, false), (26166, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (18 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26159, false) ∈ [(26159, false), (26166, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26166, false) ∈ [(26159, false), (26166, false)])))
    exact False.elim (arith_763 x g0 g1)

private theorem arith_764 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (20 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int)) : False := by
  omega

theorem clause_764 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26160, false), (26166, false)] := by
  refine if hc : Holds (assignment x) [(26160, false), (26166, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (20 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26160, false) ∈ [(26160, false), (26166, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26166, false) ∈ [(26160, false), (26166, false)])))
    exact False.elim (arith_764 x g0 g1)

private theorem arith_765 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (22 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int)) : False := by
  omega

theorem clause_765 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26161, false), (26166, false)] := by
  refine if hc : Holds (assignment x) [(26161, false), (26166, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (22 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26161, false) ∈ [(26161, false), (26166, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26166, false) ∈ [(26161, false), (26166, false)])))
    exact False.elim (arith_765 x g0 g1)

private theorem arith_766 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (17 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int)) : False := by
  omega

theorem clause_766 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26162, false), (26166, false)] := by
  refine if hc : Holds (assignment x) [(26162, false), (26166, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (17 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26162, false) ∈ [(26162, false), (26166, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26166, false) ∈ [(26162, false), (26166, false)])))
    exact False.elim (arith_766 x g0 g1)

private theorem arith_767 (x : Fin 12 → Nat)
    (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (23 : Int)) (g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int)) : False := by
  omega

theorem clause_767 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26165, false), (26166, false)] := by
  refine if hc : Holds (assignment x) [(26165, false), (26166, false)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (23 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26165, false) ∈ [(26165, false), (26166, false)])))
    have g1 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) = (24 : Int) := of_decide_eq_true (flipOfNe (deniedLiteral hc (by decide : (26166, false) ∈ [(26165, false), (26166, false)])))
    exact False.elim (arith_767 x g0 g1)

private theorem arith_768 (x : Fin 12 → Nat)
    (hz : x 0 = 3) (heq : x 0*x 0+x 1*x 1+x 2*x 2+x 3*x 3+x 4*x 4+x 5*x 5+x 6*x 6+x 7*x 7+x 8*x 8+x 9*x 9+x 10*x 10+x 11*x 11+x 11 = 24) (g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (24 : Int)) : False := by
  simp only [hz] at heq
  omega

theorem clause_768 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(26166, true)] := by
  refine if hc : Holds (assignment x) [(26166, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((9 : Int) + ((x 1 * x 1 : Nat) : Int) + ((x 2 * x 2 : Nat) : Int) + ((x 3 * x 3 : Nat) : Int) + ((x 4 * x 4 : Nat) : Int) + ((x 5 * x 5 : Nat) : Int) + ((x 6 * x 6 : Nat) : Int) + ((x 7 * x 7 : Nat) : Int) + ((x 8 * x 8 : Nat) : Int) + ((x 9 * x 9 : Nat) : Int) + ((x 10 * x 10 : Nat) : Int) + (x 11 : Int) + ((x 11 * x 11 : Nat) : Int)) ≠ (24 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (26166, true) ∈ [(26166, true)])))
    exact False.elim (arith_768 x h.zero h.square g0)

private theorem arith_769 (x : Fin 12 → Nat)
    (g0 : ((2 : Int)) ≠ (2 : Int)) : False := by
  omega

theorem clause_769 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(3, true)] := by
  refine if hc : Holds (assignment x) [(3, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((2 : Int)) ≠ (2 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (3, true) ∈ [(3, true)])))
    exact False.elim (arith_769 x g0)

private theorem arith_770 (x : Fin 12 → Nat)
    (g0 : (0 : Int) ≠ (0 : Int)) : False := by
  omega

theorem clause_770 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(4, true)] := by
  refine if hc : Holds (assignment x) [(4, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (4, true) ∈ [(4, true)])))
    exact False.elim (arith_770 x g0)

private theorem arith_771 (x : Fin 12 → Nat)
    (g0 : ((1 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_771 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(10, true)] := by
  refine if hc : Holds (assignment x) [(10, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((1 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (10, true) ∈ [(10, true)])))
    exact False.elim (arith_771 x g0)

private theorem arith_772 (x : Fin 12 → Nat)
    (g0 : ((1 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_772 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(15, true)] := by
  refine if hc : Holds (assignment x) [(15, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((1 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (15, true) ∈ [(15, true)])))
    exact False.elim (arith_772 x g0)

private theorem arith_773 (x : Fin 12 → Nat)
    (g0 : ((1 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_773 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(20, true)] := by
  refine if hc : Holds (assignment x) [(20, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((1 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (20, true) ∈ [(20, true)])))
    exact False.elim (arith_773 x g0)

private theorem arith_774 (x : Fin 12 → Nat)
    (g0 : ((1 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_774 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(25, true)] := by
  refine if hc : Holds (assignment x) [(25, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((1 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (25, true) ∈ [(25, true)])))
    exact False.elim (arith_774 x g0)

private theorem arith_775 (x : Fin 12 → Nat)
    (g0 : (0 : Int) ≠ (0 : Int)) : False := by
  omega

theorem clause_775 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(29, true)] := by
  refine if hc : Holds (assignment x) [(29, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (29, true) ∈ [(29, true)])))
    exact False.elim (arith_775 x g0)

private theorem arith_776 (x : Fin 12 → Nat)
    (g0 : (0 : Int) ≠ (0 : Int)) : False := by
  omega

theorem clause_776 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(34, true)] := by
  refine if hc : Holds (assignment x) [(34, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : (0 : Int) ≠ (0 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (34, true) ∈ [(34, true)])))
    exact False.elim (arith_776 x g0)

private theorem arith_777 (x : Fin 12 → Nat)
    (g0 : ((1 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_777 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(40, true)] := by
  refine if hc : Holds (assignment x) [(40, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((1 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (40, true) ∈ [(40, true)])))
    exact False.elim (arith_777 x g0)

private theorem arith_778 (x : Fin 12 → Nat)
    (g0 : ((1 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_778 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(45, true)] := by
  refine if hc : Holds (assignment x) [(45, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((1 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (45, true) ∈ [(45, true)])))
    exact False.elim (arith_778 x g0)

private theorem arith_779 (x : Fin 12 → Nat)
    (g0 : ((1 : Int)) ≠ (1 : Int)) : False := by
  omega

theorem clause_779 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(50, true)] := by
  refine if hc : Holds (assignment x) [(50, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((1 : Int)) ≠ (1 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (50, true) ∈ [(50, true)])))
    exact False.elim (arith_779 x g0)

private theorem arith_780 (x : Fin 12 → Nat)
    (g0 : ((3 : Int)) ≠ (3 : Int)) : False := by
  omega

theorem clause_780 (x : Fin 12 → Nat) (h : Facts x) :
    Holds (assignment x) [(57, true)] := by
  refine if hc : Holds (assignment x) [(57, true)] then ?pos else ?neg
  · exact hc
  ·
    have g0 : ((3 : Int)) ≠ (3 : Int) := of_decide_eq_false (flipOfNe (deniedLiteral hc (by decide : (57, true) ∈ [(57, true)])))
    exact False.elim (arith_780 x g0)

theorem allCons {p : Nat → Bool} {c : CNF.Clause Nat} {cs : List (CNF.Clause Nat)}
    (hc : Holds p c) (ht : (cs.all fun d => d.eval p) = true) :
    ((c :: cs).all fun d => d.eval p) = true :=
  Bool.and_eq_true_iff.mpr ⟨hc, ht⟩

theorem core_satisfied (x : Fin 12 → Nat) (h : Facts x) :
    ConwayRoot26Pilot.core.eval (assignment x) = true := by
  unfold CNF.eval
  rw [← Array.all_toList]
  exact
    allCons (clause_1 x h) (
    allCons (clause_2 x h) (
    allCons (clause_3 x h) (
    allCons (clause_4 x h) (
    allCons (clause_5 x h) (
    allCons (clause_6 x h) (
    allCons (clause_7 x h) (
    allCons (clause_8 x h) (
    allCons (clause_9 x h) (
    allCons (clause_10 x h) (
    allCons (clause_11 x h) (
    allCons (clause_12 x h) (
    allCons (clause_13 x h) (
    allCons (clause_14 x h) (
    allCons (clause_15 x h) (
    allCons (clause_16 x h) (
    allCons (clause_17 x h) (
    allCons (clause_18 x h) (
    allCons (clause_19 x h) (
    allCons (clause_20 x h) (
    allCons (clause_21 x h) (
    allCons (clause_22 x h) (
    allCons (clause_23 x h) (
    allCons (clause_24 x h) (
    allCons (clause_25 x h) (
    allCons (clause_26 x h) (
    allCons (clause_27 x h) (
    allCons (clause_28 x h) (
    allCons (clause_29 x h) (
    allCons (clause_30 x h) (
    allCons (clause_31 x h) (
    allCons (clause_32 x h) (
    allCons (clause_33 x h) (
    allCons (clause_34 x h) (
    allCons (clause_35 x h) (
    allCons (clause_36 x h) (
    allCons (clause_37 x h) (
    allCons (clause_38 x h) (
    allCons (clause_39 x h) (
    allCons (clause_40 x h) (
    allCons (clause_41 x h) (
    allCons (clause_42 x h) (
    allCons (clause_43 x h) (
    allCons (clause_44 x h) (
    allCons (clause_45 x h) (
    allCons (clause_46 x h) (
    allCons (clause_47 x h) (
    allCons (clause_48 x h) (
    allCons (clause_49 x h) (
    allCons (clause_50 x h) (
    allCons (clause_51 x h) (
    allCons (clause_52 x h) (
    allCons (clause_53 x h) (
    allCons (clause_54 x h) (
    allCons (clause_55 x h) (
    allCons (clause_56 x h) (
    allCons (clause_57 x h) (
    allCons (clause_58 x h) (
    allCons (clause_59 x h) (
    allCons (clause_60 x h) (
    allCons (clause_61 x h) (
    allCons (clause_62 x h) (
    allCons (clause_63 x h) (
    allCons (clause_64 x h) (
    allCons (clause_65 x h) (
    allCons (clause_66 x h) (
    allCons (clause_67 x h) (
    allCons (clause_68 x h) (
    allCons (clause_69 x h) (
    allCons (clause_70 x h) (
    allCons (clause_71 x h) (
    allCons (clause_72 x h) (
    allCons (clause_73 x h) (
    allCons (clause_74 x h) (
    allCons (clause_75 x h) (
    allCons (clause_76 x h) (
    allCons (clause_77 x h) (
    allCons (clause_78 x h) (
    allCons (clause_79 x h) (
    allCons (clause_80 x h) (
    allCons (clause_81 x h) (
    allCons (clause_82 x h) (
    allCons (clause_83 x h) (
    allCons (clause_84 x h) (
    allCons (clause_85 x h) (
    allCons (clause_86 x h) (
    allCons (clause_87 x h) (
    allCons (clause_88 x h) (
    allCons (clause_89 x h) (
    allCons (clause_90 x h) (
    allCons (clause_91 x h) (
    allCons (clause_92 x h) (
    allCons (clause_93 x h) (
    allCons (clause_94 x h) (
    allCons (clause_95 x h) (
    allCons (clause_96 x h) (
    allCons (clause_97 x h) (
    allCons (clause_98 x h) (
    allCons (clause_99 x h) (
    allCons (clause_100 x h) (
    allCons (clause_101 x h) (
    allCons (clause_102 x h) (
    allCons (clause_103 x h) (
    allCons (clause_104 x h) (
    allCons (clause_105 x h) (
    allCons (clause_106 x h) (
    allCons (clause_107 x h) (
    allCons (clause_108 x h) (
    allCons (clause_109 x h) (
    allCons (clause_110 x h) (
    allCons (clause_111 x h) (
    allCons (clause_112 x h) (
    allCons (clause_113 x h) (
    allCons (clause_114 x h) (
    allCons (clause_115 x h) (
    allCons (clause_116 x h) (
    allCons (clause_117 x h) (
    allCons (clause_118 x h) (
    allCons (clause_119 x h) (
    allCons (clause_120 x h) (
    allCons (clause_121 x h) (
    allCons (clause_122 x h) (
    allCons (clause_123 x h) (
    allCons (clause_124 x h) (
    allCons (clause_125 x h) (
    allCons (clause_126 x h) (
    allCons (clause_127 x h) (
    allCons (clause_128 x h) (
    allCons (clause_129 x h) (
    allCons (clause_130 x h) (
    allCons (clause_131 x h) (
    allCons (clause_132 x h) (
    allCons (clause_133 x h) (
    allCons (clause_134 x h) (
    allCons (clause_135 x h) (
    allCons (clause_136 x h) (
    allCons (clause_137 x h) (
    allCons (clause_138 x h) (
    allCons (clause_139 x h) (
    allCons (clause_140 x h) (
    allCons (clause_141 x h) (
    allCons (clause_142 x h) (
    allCons (clause_143 x h) (
    allCons (clause_144 x h) (
    allCons (clause_145 x h) (
    allCons (clause_146 x h) (
    allCons (clause_147 x h) (
    allCons (clause_148 x h) (
    allCons (clause_149 x h) (
    allCons (clause_150 x h) (
    allCons (clause_151 x h) (
    allCons (clause_152 x h) (
    allCons (clause_153 x h) (
    allCons (clause_154 x h) (
    allCons (clause_155 x h) (
    allCons (clause_156 x h) (
    allCons (clause_157 x h) (
    allCons (clause_158 x h) (
    allCons (clause_159 x h) (
    allCons (clause_160 x h) (
    allCons (clause_161 x h) (
    allCons (clause_162 x h) (
    allCons (clause_163 x h) (
    allCons (clause_164 x h) (
    allCons (clause_165 x h) (
    allCons (clause_166 x h) (
    allCons (clause_167 x h) (
    allCons (clause_168 x h) (
    allCons (clause_169 x h) (
    allCons (clause_170 x h) (
    allCons (clause_171 x h) (
    allCons (clause_172 x h) (
    allCons (clause_173 x h) (
    allCons (clause_174 x h) (
    allCons (clause_175 x h) (
    allCons (clause_176 x h) (
    allCons (clause_177 x h) (
    allCons (clause_178 x h) (
    allCons (clause_179 x h) (
    allCons (clause_180 x h) (
    allCons (clause_181 x h) (
    allCons (clause_182 x h) (
    allCons (clause_183 x h) (
    allCons (clause_184 x h) (
    allCons (clause_185 x h) (
    allCons (clause_186 x h) (
    allCons (clause_187 x h) (
    allCons (clause_188 x h) (
    allCons (clause_189 x h) (
    allCons (clause_190 x h) (
    allCons (clause_191 x h) (
    allCons (clause_192 x h) (
    allCons (clause_193 x h) (
    allCons (clause_194 x h) (
    allCons (clause_195 x h) (
    allCons (clause_196 x h) (
    allCons (clause_197 x h) (
    allCons (clause_198 x h) (
    allCons (clause_199 x h) (
    allCons (clause_200 x h) (
    allCons (clause_201 x h) (
    allCons (clause_202 x h) (
    allCons (clause_203 x h) (
    allCons (clause_204 x h) (
    allCons (clause_205 x h) (
    allCons (clause_206 x h) (
    allCons (clause_207 x h) (
    allCons (clause_208 x h) (
    allCons (clause_209 x h) (
    allCons (clause_210 x h) (
    allCons (clause_211 x h) (
    allCons (clause_212 x h) (
    allCons (clause_213 x h) (
    allCons (clause_214 x h) (
    allCons (clause_215 x h) (
    allCons (clause_216 x h) (
    allCons (clause_217 x h) (
    allCons (clause_218 x h) (
    allCons (clause_219 x h) (
    allCons (clause_220 x h) (
    allCons (clause_221 x h) (
    allCons (clause_222 x h) (
    allCons (clause_223 x h) (
    allCons (clause_224 x h) (
    allCons (clause_225 x h) (
    allCons (clause_226 x h) (
    allCons (clause_227 x h) (
    allCons (clause_228 x h) (
    allCons (clause_229 x h) (
    allCons (clause_230 x h) (
    allCons (clause_231 x h) (
    allCons (clause_232 x h) (
    allCons (clause_233 x h) (
    allCons (clause_234 x h) (
    allCons (clause_235 x h) (
    allCons (clause_236 x h) (
    allCons (clause_237 x h) (
    allCons (clause_238 x h) (
    allCons (clause_239 x h) (
    allCons (clause_240 x h) (
    allCons (clause_241 x h) (
    allCons (clause_242 x h) (
    allCons (clause_243 x h) (
    allCons (clause_244 x h) (
    allCons (clause_245 x h) (
    allCons (clause_246 x h) (
    allCons (clause_247 x h) (
    allCons (clause_248 x h) (
    allCons (clause_249 x h) (
    allCons (clause_250 x h) (
    allCons (clause_251 x h) (
    allCons (clause_252 x h) (
    allCons (clause_253 x h) (
    allCons (clause_254 x h) (
    allCons (clause_255 x h) (
    allCons (clause_256 x h) (
    allCons (clause_257 x h) (
    allCons (clause_258 x h) (
    allCons (clause_259 x h) (
    allCons (clause_260 x h) (
    allCons (clause_261 x h) (
    allCons (clause_262 x h) (
    allCons (clause_263 x h) (
    allCons (clause_264 x h) (
    allCons (clause_265 x h) (
    allCons (clause_266 x h) (
    allCons (clause_267 x h) (
    allCons (clause_268 x h) (
    allCons (clause_269 x h) (
    allCons (clause_270 x h) (
    allCons (clause_271 x h) (
    allCons (clause_272 x h) (
    allCons (clause_273 x h) (
    allCons (clause_274 x h) (
    allCons (clause_275 x h) (
    allCons (clause_276 x h) (
    allCons (clause_277 x h) (
    allCons (clause_278 x h) (
    allCons (clause_279 x h) (
    allCons (clause_280 x h) (
    allCons (clause_281 x h) (
    allCons (clause_282 x h) (
    allCons (clause_283 x h) (
    allCons (clause_284 x h) (
    allCons (clause_285 x h) (
    allCons (clause_286 x h) (
    allCons (clause_287 x h) (
    allCons (clause_288 x h) (
    allCons (clause_289 x h) (
    allCons (clause_290 x h) (
    allCons (clause_291 x h) (
    allCons (clause_292 x h) (
    allCons (clause_293 x h) (
    allCons (clause_294 x h) (
    allCons (clause_295 x h) (
    allCons (clause_296 x h) (
    allCons (clause_297 x h) (
    allCons (clause_298 x h) (
    allCons (clause_299 x h) (
    allCons (clause_300 x h) (
    allCons (clause_301 x h) (
    allCons (clause_302 x h) (
    allCons (clause_303 x h) (
    allCons (clause_304 x h) (
    allCons (clause_305 x h) (
    allCons (clause_306 x h) (
    allCons (clause_307 x h) (
    allCons (clause_308 x h) (
    allCons (clause_309 x h) (
    allCons (clause_310 x h) (
    allCons (clause_311 x h) (
    allCons (clause_312 x h) (
    allCons (clause_313 x h) (
    allCons (clause_314 x h) (
    allCons (clause_315 x h) (
    allCons (clause_316 x h) (
    allCons (clause_317 x h) (
    allCons (clause_318 x h) (
    allCons (clause_319 x h) (
    allCons (clause_320 x h) (
    allCons (clause_321 x h) (
    allCons (clause_322 x h) (
    allCons (clause_323 x h) (
    allCons (clause_324 x h) (
    allCons (clause_325 x h) (
    allCons (clause_326 x h) (
    allCons (clause_327 x h) (
    allCons (clause_328 x h) (
    allCons (clause_329 x h) (
    allCons (clause_330 x h) (
    allCons (clause_331 x h) (
    allCons (clause_332 x h) (
    allCons (clause_333 x h) (
    allCons (clause_334 x h) (
    allCons (clause_335 x h) (
    allCons (clause_336 x h) (
    allCons (clause_337 x h) (
    allCons (clause_338 x h) (
    allCons (clause_339 x h) (
    allCons (clause_340 x h) (
    allCons (clause_341 x h) (
    allCons (clause_342 x h) (
    allCons (clause_343 x h) (
    allCons (clause_344 x h) (
    allCons (clause_345 x h) (
    allCons (clause_346 x h) (
    allCons (clause_347 x h) (
    allCons (clause_348 x h) (
    allCons (clause_349 x h) (
    allCons (clause_350 x h) (
    allCons (clause_351 x h) (
    allCons (clause_352 x h) (
    allCons (clause_353 x h) (
    allCons (clause_354 x h) (
    allCons (clause_355 x h) (
    allCons (clause_356 x h) (
    allCons (clause_357 x h) (
    allCons (clause_358 x h) (
    allCons (clause_359 x h) (
    allCons (clause_360 x h) (
    allCons (clause_361 x h) (
    allCons (clause_362 x h) (
    allCons (clause_363 x h) (
    allCons (clause_364 x h) (
    allCons (clause_365 x h) (
    allCons (clause_366 x h) (
    allCons (clause_367 x h) (
    allCons (clause_368 x h) (
    allCons (clause_369 x h) (
    allCons (clause_370 x h) (
    allCons (clause_371 x h) (
    allCons (clause_372 x h) (
    allCons (clause_373 x h) (
    allCons (clause_374 x h) (
    allCons (clause_375 x h) (
    allCons (clause_376 x h) (
    allCons (clause_377 x h) (
    allCons (clause_378 x h) (
    allCons (clause_379 x h) (
    allCons (clause_380 x h) (
    allCons (clause_381 x h) (
    allCons (clause_382 x h) (
    allCons (clause_383 x h) (
    allCons (clause_384 x h) (
    allCons (clause_385 x h) (
    allCons (clause_386 x h) (
    allCons (clause_387 x h) (
    allCons (clause_388 x h) (
    allCons (clause_389 x h) (
    allCons (clause_390 x h) (
    allCons (clause_391 x h) (
    allCons (clause_392 x h) (
    allCons (clause_393 x h) (
    allCons (clause_394 x h) (
    allCons (clause_395 x h) (
    allCons (clause_396 x h) (
    allCons (clause_397 x h) (
    allCons (clause_398 x h) (
    allCons (clause_399 x h) (
    allCons (clause_400 x h) (
    allCons (clause_401 x h) (
    allCons (clause_402 x h) (
    allCons (clause_403 x h) (
    allCons (clause_404 x h) (
    allCons (clause_405 x h) (
    allCons (clause_406 x h) (
    allCons (clause_407 x h) (
    allCons (clause_408 x h) (
    allCons (clause_409 x h) (
    allCons (clause_410 x h) (
    allCons (clause_411 x h) (
    allCons (clause_412 x h) (
    allCons (clause_413 x h) (
    allCons (clause_414 x h) (
    allCons (clause_415 x h) (
    allCons (clause_416 x h) (
    allCons (clause_417 x h) (
    allCons (clause_418 x h) (
    allCons (clause_419 x h) (
    allCons (clause_420 x h) (
    allCons (clause_421 x h) (
    allCons (clause_422 x h) (
    allCons (clause_423 x h) (
    allCons (clause_424 x h) (
    allCons (clause_425 x h) (
    allCons (clause_426 x h) (
    allCons (clause_427 x h) (
    allCons (clause_428 x h) (
    allCons (clause_429 x h) (
    allCons (clause_430 x h) (
    allCons (clause_431 x h) (
    allCons (clause_432 x h) (
    allCons (clause_433 x h) (
    allCons (clause_434 x h) (
    allCons (clause_435 x h) (
    allCons (clause_436 x h) (
    allCons (clause_437 x h) (
    allCons (clause_438 x h) (
    allCons (clause_439 x h) (
    allCons (clause_440 x h) (
    allCons (clause_441 x h) (
    allCons (clause_442 x h) (
    allCons (clause_443 x h) (
    allCons (clause_444 x h) (
    allCons (clause_445 x h) (
    allCons (clause_446 x h) (
    allCons (clause_447 x h) (
    allCons (clause_448 x h) (
    allCons (clause_449 x h) (
    allCons (clause_450 x h) (
    allCons (clause_451 x h) (
    allCons (clause_452 x h) (
    allCons (clause_453 x h) (
    allCons (clause_454 x h) (
    allCons (clause_455 x h) (
    allCons (clause_456 x h) (
    allCons (clause_457 x h) (
    allCons (clause_458 x h) (
    allCons (clause_459 x h) (
    allCons (clause_460 x h) (
    allCons (clause_461 x h) (
    allCons (clause_462 x h) (
    allCons (clause_463 x h) (
    allCons (clause_464 x h) (
    allCons (clause_465 x h) (
    allCons (clause_466 x h) (
    allCons (clause_467 x h) (
    allCons (clause_468 x h) (
    allCons (clause_469 x h) (
    allCons (clause_470 x h) (
    allCons (clause_471 x h) (
    allCons (clause_472 x h) (
    allCons (clause_473 x h) (
    allCons (clause_474 x h) (
    allCons (clause_475 x h) (
    allCons (clause_476 x h) (
    allCons (clause_477 x h) (
    allCons (clause_478 x h) (
    allCons (clause_479 x h) (
    allCons (clause_480 x h) (
    allCons (clause_481 x h) (
    allCons (clause_482 x h) (
    allCons (clause_483 x h) (
    allCons (clause_484 x h) (
    allCons (clause_485 x h) (
    allCons (clause_486 x h) (
    allCons (clause_487 x h) (
    allCons (clause_488 x h) (
    allCons (clause_489 x h) (
    allCons (clause_490 x h) (
    allCons (clause_491 x h) (
    allCons (clause_492 x h) (
    allCons (clause_493 x h) (
    allCons (clause_494 x h) (
    allCons (clause_495 x h) (
    allCons (clause_496 x h) (
    allCons (clause_497 x h) (
    allCons (clause_498 x h) (
    allCons (clause_499 x h) (
    allCons (clause_500 x h) (
    allCons (clause_501 x h) (
    allCons (clause_502 x h) (
    allCons (clause_503 x h) (
    allCons (clause_504 x h) (
    allCons (clause_505 x h) (
    allCons (clause_506 x h) (
    allCons (clause_507 x h) (
    allCons (clause_508 x h) (
    allCons (clause_509 x h) (
    allCons (clause_510 x h) (
    allCons (clause_511 x h) (
    allCons (clause_512 x h) (
    allCons (clause_513 x h) (
    allCons (clause_514 x h) (
    allCons (clause_515 x h) (
    allCons (clause_516 x h) (
    allCons (clause_517 x h) (
    allCons (clause_518 x h) (
    allCons (clause_519 x h) (
    allCons (clause_520 x h) (
    allCons (clause_521 x h) (
    allCons (clause_522 x h) (
    allCons (clause_523 x h) (
    allCons (clause_524 x h) (
    allCons (clause_525 x h) (
    allCons (clause_526 x h) (
    allCons (clause_527 x h) (
    allCons (clause_528 x h) (
    allCons (clause_529 x h) (
    allCons (clause_530 x h) (
    allCons (clause_531 x h) (
    allCons (clause_532 x h) (
    allCons (clause_533 x h) (
    allCons (clause_534 x h) (
    allCons (clause_535 x h) (
    allCons (clause_536 x h) (
    allCons (clause_537 x h) (
    allCons (clause_538 x h) (
    allCons (clause_539 x h) (
    allCons (clause_540 x h) (
    allCons (clause_541 x h) (
    allCons (clause_542 x h) (
    allCons (clause_543 x h) (
    allCons (clause_544 x h) (
    allCons (clause_545 x h) (
    allCons (clause_546 x h) (
    allCons (clause_547 x h) (
    allCons (clause_548 x h) (
    allCons (clause_549 x h) (
    allCons (clause_550 x h) (
    allCons (clause_551 x h) (
    allCons (clause_552 x h) (
    allCons (clause_553 x h) (
    allCons (clause_554 x h) (
    allCons (clause_555 x h) (
    allCons (clause_556 x h) (
    allCons (clause_557 x h) (
    allCons (clause_558 x h) (
    allCons (clause_559 x h) (
    allCons (clause_560 x h) (
    allCons (clause_561 x h) (
    allCons (clause_562 x h) (
    allCons (clause_563 x h) (
    allCons (clause_564 x h) (
    allCons (clause_565 x h) (
    allCons (clause_566 x h) (
    allCons (clause_567 x h) (
    allCons (clause_568 x h) (
    allCons (clause_569 x h) (
    allCons (clause_570 x h) (
    allCons (clause_571 x h) (
    allCons (clause_572 x h) (
    allCons (clause_573 x h) (
    allCons (clause_574 x h) (
    allCons (clause_575 x h) (
    allCons (clause_576 x h) (
    allCons (clause_577 x h) (
    allCons (clause_578 x h) (
    allCons (clause_579 x h) (
    allCons (clause_580 x h) (
    allCons (clause_581 x h) (
    allCons (clause_582 x h) (
    allCons (clause_583 x h) (
    allCons (clause_584 x h) (
    allCons (clause_585 x h) (
    allCons (clause_586 x h) (
    allCons (clause_587 x h) (
    allCons (clause_588 x h) (
    allCons (clause_589 x h) (
    allCons (clause_590 x h) (
    allCons (clause_591 x h) (
    allCons (clause_592 x h) (
    allCons (clause_593 x h) (
    allCons (clause_594 x h) (
    allCons (clause_595 x h) (
    allCons (clause_596 x h) (
    allCons (clause_597 x h) (
    allCons (clause_598 x h) (
    allCons (clause_599 x h) (
    allCons (clause_600 x h) (
    allCons (clause_601 x h) (
    allCons (clause_602 x h) (
    allCons (clause_603 x h) (
    allCons (clause_604 x h) (
    allCons (clause_605 x h) (
    allCons (clause_606 x h) (
    allCons (clause_607 x h) (
    allCons (clause_608 x h) (
    allCons (clause_609 x h) (
    allCons (clause_610 x h) (
    allCons (clause_611 x h) (
    allCons (clause_612 x h) (
    allCons (clause_613 x h) (
    allCons (clause_614 x h) (
    allCons (clause_615 x h) (
    allCons (clause_616 x h) (
    allCons (clause_617 x h) (
    allCons (clause_618 x h) (
    allCons (clause_619 x h) (
    allCons (clause_620 x h) (
    allCons (clause_621 x h) (
    allCons (clause_622 x h) (
    allCons (clause_623 x h) (
    allCons (clause_624 x h) (
    allCons (clause_625 x h) (
    allCons (clause_626 x h) (
    allCons (clause_627 x h) (
    allCons (clause_628 x h) (
    allCons (clause_629 x h) (
    allCons (clause_630 x h) (
    allCons (clause_631 x h) (
    allCons (clause_632 x h) (
    allCons (clause_633 x h) (
    allCons (clause_634 x h) (
    allCons (clause_635 x h) (
    allCons (clause_636 x h) (
    allCons (clause_637 x h) (
    allCons (clause_638 x h) (
    allCons (clause_639 x h) (
    allCons (clause_640 x h) (
    allCons (clause_641 x h) (
    allCons (clause_642 x h) (
    allCons (clause_643 x h) (
    allCons (clause_644 x h) (
    allCons (clause_645 x h) (
    allCons (clause_646 x h) (
    allCons (clause_647 x h) (
    allCons (clause_648 x h) (
    allCons (clause_649 x h) (
    allCons (clause_650 x h) (
    allCons (clause_651 x h) (
    allCons (clause_652 x h) (
    allCons (clause_653 x h) (
    allCons (clause_654 x h) (
    allCons (clause_655 x h) (
    allCons (clause_656 x h) (
    allCons (clause_657 x h) (
    allCons (clause_658 x h) (
    allCons (clause_659 x h) (
    allCons (clause_660 x h) (
    allCons (clause_661 x h) (
    allCons (clause_662 x h) (
    allCons (clause_663 x h) (
    allCons (clause_664 x h) (
    allCons (clause_665 x h) (
    allCons (clause_666 x h) (
    allCons (clause_667 x h) (
    allCons (clause_668 x h) (
    allCons (clause_669 x h) (
    allCons (clause_670 x h) (
    allCons (clause_671 x h) (
    allCons (clause_672 x h) (
    allCons (clause_673 x h) (
    allCons (clause_674 x h) (
    allCons (clause_675 x h) (
    allCons (clause_676 x h) (
    allCons (clause_677 x h) (
    allCons (clause_678 x h) (
    allCons (clause_679 x h) (
    allCons (clause_680 x h) (
    allCons (clause_681 x h) (
    allCons (clause_682 x h) (
    allCons (clause_683 x h) (
    allCons (clause_684 x h) (
    allCons (clause_685 x h) (
    allCons (clause_686 x h) (
    allCons (clause_687 x h) (
    allCons (clause_688 x h) (
    allCons (clause_689 x h) (
    allCons (clause_690 x h) (
    allCons (clause_691 x h) (
    allCons (clause_692 x h) (
    allCons (clause_693 x h) (
    allCons (clause_694 x h) (
    allCons (clause_695 x h) (
    allCons (clause_696 x h) (
    allCons (clause_697 x h) (
    allCons (clause_698 x h) (
    allCons (clause_699 x h) (
    allCons (clause_700 x h) (
    allCons (clause_701 x h) (
    allCons (clause_702 x h) (
    allCons (clause_703 x h) (
    allCons (clause_704 x h) (
    allCons (clause_705 x h) (
    allCons (clause_706 x h) (
    allCons (clause_707 x h) (
    allCons (clause_708 x h) (
    allCons (clause_709 x h) (
    allCons (clause_710 x h) (
    allCons (clause_711 x h) (
    allCons (clause_712 x h) (
    allCons (clause_713 x h) (
    allCons (clause_714 x h) (
    allCons (clause_715 x h) (
    allCons (clause_716 x h) (
    allCons (clause_717 x h) (
    allCons (clause_718 x h) (
    allCons (clause_719 x h) (
    allCons (clause_720 x h) (
    allCons (clause_721 x h) (
    allCons (clause_722 x h) (
    allCons (clause_723 x h) (
    allCons (clause_724 x h) (
    allCons (clause_725 x h) (
    allCons (clause_726 x h) (
    allCons (clause_727 x h) (
    allCons (clause_728 x h) (
    allCons (clause_729 x h) (
    allCons (clause_730 x h) (
    allCons (clause_731 x h) (
    allCons (clause_732 x h) (
    allCons (clause_733 x h) (
    allCons (clause_734 x h) (
    allCons (clause_735 x h) (
    allCons (clause_736 x h) (
    allCons (clause_737 x h) (
    allCons (clause_738 x h) (
    allCons (clause_739 x h) (
    allCons (clause_740 x h) (
    allCons (clause_741 x h) (
    allCons (clause_742 x h) (
    allCons (clause_743 x h) (
    allCons (clause_744 x h) (
    allCons (clause_745 x h) (
    allCons (clause_746 x h) (
    allCons (clause_747 x h) (
    allCons (clause_748 x h) (
    allCons (clause_749 x h) (
    allCons (clause_750 x h) (
    allCons (clause_751 x h) (
    allCons (clause_752 x h) (
    allCons (clause_753 x h) (
    allCons (clause_754 x h) (
    allCons (clause_755 x h) (
    allCons (clause_756 x h) (
    allCons (clause_757 x h) (
    allCons (clause_758 x h) (
    allCons (clause_759 x h) (
    allCons (clause_760 x h) (
    allCons (clause_761 x h) (
    allCons (clause_762 x h) (
    allCons (clause_763 x h) (
    allCons (clause_764 x h) (
    allCons (clause_765 x h) (
    allCons (clause_766 x h) (
    allCons (clause_767 x h) (
    allCons (clause_768 x h) (
    allCons (clause_769 x h) (
    allCons (clause_770 x h) (
    allCons (clause_771 x h) (
    allCons (clause_772 x h) (
    allCons (clause_773 x h) (
    allCons (clause_774 x h) (
    allCons (clause_775 x h) (
    allCons (clause_776 x h) (
    allCons (clause_777 x h) (
    allCons (clause_778 x h) (
    allCons (clause_779 x h) (
    allCons (clause_780 x h) (
      (by rfl)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

#print axioms core_satisfied

end Matrix99.Z7Root26Model
