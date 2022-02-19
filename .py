import argparse
import time


def gen(delay, audio, video, timestamp):
    u = timestamp if timestamp is not None else time.time() + delay
    d = 10
    c = [
        [59],
        [1, 10, 24, 28, 37, 40, 48],
        [9, 13, 21, 31, 46, 53, 57],
        [14, 18, 23, 29, 56],
        [4, 11, 16, 30, 34, 42, 47, 55],
        [7, 17, 20, 33, 38, 58],
        [12, 22, 27, 41, 44, 51],
        [2, 6, 15, 36, 43, 52],
        [0, 3, 8, 26, 32, 35, 49],
        [5, 19, 25, 39, 45, 50, 54],
    ]
    h = [f"{int((v+u//3600)%24):02d}" for v in range(24)]
    m = range(6)
    s = u % 3600
    ss = u % 86400
    segs = filter(
        None,
        [
            f"{''.join(f'amovie=minute_{v}0.wav,aloop=10:44100*60[mm{v}];'for v in m)}{''.join(f'amovie=hour_{v}.wav,aloop=60:44100*60[h{v}];'for v in h)}amovie=cycle_600s.wav,aloop=-1:44100*600[s600];amovie=cycle_60s.wav,aloop=-1:44100*60[s60];{''.join(f'amovie=cycle_60s_{i:02d}.wav,asplit={len(v)}'+''.join(f'[m{n}]'for n in v)+';'for i, v in enumerate(c))}{''.join(f'[mm{v}]'for v in m)}concat=v=0:a=1:n=6,aloop=-1:44100*60*60[m];{''.join(f'[m{v}]'for v in range(60))}concat=v=0:a=1:n=60,aloop=-1:44100*60*60[hh];{''.join(f'[h{v}]'for v in h)}concat=v=0:a=1:n=24,asplit={d}{''.join(f'[d{v}]'for v in range(d))};{''.join(f'[d{v}]'for v in range(d))}concat=v=0:a=1:n={d}[h];[hh][s60][m][h][s600]amix=inputs=5,volume=5,atrim={s},asetpts=PTS-STARTPTS"
            if audio
            else None,
            f"gradients=size=1920x1080:x0=1:x1=1919:y0=1:y1=1079:r=7,drawtext=text='%{{pts\:localtime\:{ss}\:%H\\\\\:%M\\\\\:%S}}':fontsize=127:fontfile=./.ttf:box=1:boxborderw=23:x=(w-tw)/2:y=(h-lh)/2"
            if video
            else None,
        ],
    )
    return ";".join(f"{s}[out{i}]" for i, s in enumerate(segs))


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    av = ap.add_mutually_exclusive_group()
    av.add_argument("--no-video", "-a", action="store_false", dest="video")
    av.add_argument("--no-audio", "-v", action="store_false", dest="audio")
    ap.add_argument("--timestamp", "-t", type=float, nargs="?")
    ap.add_argument(
        "delay",
        type=float,
        nargs="?",
        default=5.5,
    )
    print(gen(**ap.parse_args().__dict__))
