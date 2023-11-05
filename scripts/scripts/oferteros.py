'''Conversión de PDF a imágenes'''
from datetime import datetime
import os
import time
import logging
import sys
import re
import pyinotify
from pdf2image import convert_from_path as pdf_converter


def get_logdir():
    log_file = os.environ.get('LOGPDF')
    if not log_file:
        log_file = 'log_pdf.log'

    return log_file


def split_path(path):
    path_tuple = os.path.split(path)
    return path_tuple


def dir_listener(watch_dir):
    timestamp = datetime.now().strftime("%Y/%m/%d - %H:%M:%S")
    logging.info('---- %s ----', timestamp)
    logging.info('Escuchando en: %s', watch_dir)
    while True:
        watcher = pyinotify.WatchManager()
        notifier = pyinotify.Notifier(watcher, default_proc_fun=event_handler)
        watcher.add_watch(watch_dir, pyinotify.IN_CLOSE_WRITE)
        # Comienza a escuchar eventos
        notifier.loop()


def event_handler(event):
    event_type = event.maskname
    logging.info('Evento: %s', event_type)
    # El evento se dispara cuando se cierra un archivo escrito
    file = event.name
    logging.info('Nombre del archivo: %s', file)
    convert_pdf(watch_dir, file)


def convert_pdf(directory, file):
    # Comprobando que el archivo termine en pdf
    if re.search('.*\.pdf$', file):
        timestamp = datetime.now().strftime("%Y/%m/%d - %H:%M:%S")
        logging.info('---- %s ----', timestamp)
        logging.info('Archivo: %s', file)
        file_name = file[:-4]
        file_path = directory + '/' + file
        logging.info('Ruta absoluta: %s', file_path)
        dir_name = file_path[:-4]
        try:
            images = pdf_converter(file_path)
            os.mkdir(dir_name)
            for i, img in enumerate(images):
                img.save(f'{dir_name}/{file_name} ({i + 1}).jpg', 'JPEG')
            os.rename(file_path, dir_name + '/' + file)

        except Exception as e:
            timestamp = datetime.now().strftime("%Y/%m/%d - %H:%M:%S")
            logging.error('---- %s ----', timestamp)
            logging.error('Error: %s', e)
            time.sleep(2)
            convert_pdf(file)


if __name__ == '__main__':
    # Archivo de log
    log_file = get_logdir()
    logging.basicConfig(filename=log_file, level=logging.INFO)

    # Directorio a escuchar obtenido de argumentos
    received_path = sys.argv[1]

    if os.path.isdir(received_path):
        watch_dir = received_path
        dir_listener(received_path)
    else:
        file_path = split_path(received_path)
        convert_pdf(*file_path)
