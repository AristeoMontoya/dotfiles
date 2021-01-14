from datetime import datetime
import time
import logging
import sys
import re
import os
import pyinotify
from pdf2image import convert_from_path as pdf_converter


def convert_pdf(event):
    event_type = event.maskname
    logging.info(f'Evento: {event_type}')

    if event_type in ('IN_MOVED_TO', 'IN_CREATE'):
        logging.info('Entre los eventos válidos')
        file = event.name
        logging.info(f'Nombre del archivo: {file}')

        # Comprobando que el archivo termine en pdf
        if re.search('.*\.pdf$', file):
            logging.info('Es PDF')
            file_path = watch_dir + '/' + file
            dir_name = file_path[:-4]
            try:
                images = pdf_converter(file_path)
                os.mkdir(dir_name)
                for i, img in enumerate(images):
                    img.save(f'{dir_name}/Ofertero ({i + 1}).jpg', 'JPEG')
                os.rename(file_path, dir_name + '/' + file)

            except Exception as e:
                timestamp = datetime.now().strftime("%Y/%m/%d - %H:%M%:%S")
                logging.error(f'---- {timestamp} ----')
                logging.error(f'Error: {e}')
                time.sleep(2)
                convert_pdf(event)


if __name__ == '__main__':
    # Archivo de log
    log_file = '/home/pi/scripts/log_oferteros.log'
    logging.basicConfig(filename=log_file, level=logging.INFO)

    # Directorio a escuchar obtenido de argumentos
    watch_dir = sys.argv[1]
    while True:
        watcher = pyinotify.WatchManager()

        notifier = pyinotify.Notifier(watcher, default_proc_fun=convert_pdf)
        watcher.add_watch(watch_dir, pyinotify.ALL_EVENTS)

        # Comienza a escuchar eventos
        notifier.loop()
